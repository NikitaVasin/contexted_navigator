import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../contract/contexted_navigator.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';
part 'widgets/navigation_container.dart';
part 'widgets/contexted_navigator_provider.dart';
part 'widgets/navigator_stack_provider.dart';
part 'widgets/cupertino_pop.dart';
part 'widgets/no_animation_page.dart';
part '../contract/navigator_stack.dart';
part '../contract/contexted_navigator_delegate.dart';
part '../contract/interceptor.dart';

class _ContextedNavigator<Event extends NavigationEvent>
    extends Bloc<NavigationEvent, NavigationState>
    implements ContextedNavigator<Event> {
  final ValueNotifier<String?> _deepLinkNotifier = ValueNotifier(null);
  final ContextedNavigatorDelegate<Event> delegate;

  _ContextedNavigator? _parentNavigator;
  late _ContextedNavigator _rootNavigator;

  List<Page> _pages = [];

  _ContextedNavigator({
    required this.delegate,
    required List<Page> initialPages,
  }) : super(NavigationState(List.of(initialPages))) {
    _pages = List.of(initialPages);
    for (var interceptor in delegate.interceptors) {
      interceptor._pushPages = _pushPages;
    }
  }

  static _ContextedNavigator<Event>? _of<Event extends NavigationEvent>(
      BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
            _ContextedNavigatorInherited<Event>>()
        ?.navigator;
  }

  void _pushPages(List<Page> pages) {
    _pages = List.of(pages);
    emit(NavigationState(_pages));
  }

  bool _isNavigatorAllowBack() {
    return delegate.allowNavigatorSwipe(List.of(_pages));
  }

  @override
  void add(NavigationEvent event) async {
    bool should = false;
    for (var interceptor in delegate.interceptors) {
      final res = await interceptor.shouldInterrupt(event, List.of(_pages));
      if (interceptor.isActive && res) {
        should = true;
      }
    }
    if (!should) super.add(event);
  }

  @override
  List<Page> get pages => _pages.toList();

  @override
  void addEvent(Event event) => add(event);

  @override
  void clearInterceptors() => delegate.interceptors.clear();

  @override
  List<ContextedNavigatorInterceptor> get interceptors =>
      List.of(delegate.interceptors);

  @override
  void startDeepLink(String uri) =>
      _rootNavigator.add(NavigationDeepLinkEvent(uri));

  @override
  void startLocalDeepLink(String uri) => add(NavigationDeepLinkEvent(uri));

  @override
  void addInterceptor(ContextedNavigatorInterceptor interceptor) =>
      delegate.interceptors.add(interceptor);

  @override
  void removeInterceptor(ContextedNavigatorInterceptor interceptor) =>
      delegate.interceptors.remove(interceptor);

  @override
  void pop() => add(NavigationWillPopEvent());

  @override
  void pushPages(List<Page> pages) => add(NavigationPageChangeEvent(pages));

  void _notifyChildrenDeepLink(String uri) {
    final clearUri = uri.startsWith('/') ? uri.replaceFirst('/', '') : uri;
    final sendUriList = clearUri.split('/');
    if (sendUriList.length > 1) {
      _deepLinkNotifier.value = sendUriList.sublist(1).join('/');
    }
  }

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is NavigationDeepLinkEvent) {
      _pages = await delegate.mapDeepLinkToPages(event.uri, List.of(_pages));
      _notifyChildrenDeepLink(event.uri);
    } else if (event is NavigationPageChangeEvent) {
      _pages = event.pages;
    } else if (event is NavigationWillPopEvent) {
      _pages = delegate.mapWillPopToPages(List.of(_pages));
    } else if (event is Event) {
      _pages = delegate.mapEventToPages(event, List.of(_pages));
    }
    assert(_pages.isNotEmpty);
    for (var page in _pages) {
      assert(page.key != null);
    }
    final keysSet = _pages.map((e) => e.key).toSet().toList();
    _pages = List.generate(
      keysSet.length,
      (index) => _pages.firstWhere((element) => element.key == keysSet[index]),
    );
    yield NavigationState(_pages);
  }
}
