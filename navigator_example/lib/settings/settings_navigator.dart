import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/interceptors/check_finish_interceptors.dart';
import 'package:navigator_example/settings/screens/first_setting_screen.dart';
import 'package:navigator_example/settings/screens/second_settings_screen.dart';

abstract class SettingsEvent extends NavigationEvent {}

class SettingsSecondEvent extends SettingsEvent {}

class SettingsInitialEvent extends SettingsEvent {}

class SettingsNavigator extends ContextedNavigatorDelegate<SettingsEvent> {
  final CheckFinishInterceptor checkFinishInterceptors =
      CheckFinishInterceptor();

  Page _first([String? id]) => CustomMaterialPage(
        key: ValueKey('first'),
        child: FirstSettingsScreen(
          id: id,
        ),
      );

  Page get _second => CustomMaterialPage(
        key: ValueKey('second'),
        child: SecondSettingsScreen(),
      );

  @override
  Map<String, DeepLinkPageBuilder> get deepLinks => {
        'first': (params) =>
            params.containsKey('id') ? _first(params['id']!) : _first(),
        'second': (_) => _second,
      };

  @override
  Future<List<Page>> mapEventToPages(
      SettingsEvent event, List<Page> pages) async {
    if (event is SettingsInitialEvent) {
      return [_first()];
    } else if (event is SettingsSecondEvent) {
      return pages..add(_second);
    }
    return pages;
  }

  @override
  List<Page> get initialPages => [_first()];

  @override
  List<ContextedNavigatorInterceptor> get interceptors => [
        checkFinishInterceptors,
      ];
}
