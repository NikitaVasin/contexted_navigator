part of '../contexted_navigator.dart';

class _ContextedNavigatorInherited<Event extends NavigationEvent>
    extends InheritedWidget {
  final _ContextedNavigator<Event> navigator;

  _ContextedNavigatorInherited({
    required this.navigator,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(
      covariant _ContextedNavigatorInherited<Event> oldWidget) {
    return navigator != oldWidget.navigator;
  }
}

/// для того чтобы можно было получить родительский навигатор
/// без указания дженерика
class _ContextedNavigatorInheritedWithoutType extends InheritedWidget {
  final _ContextedNavigator navigator;

  _ContextedNavigatorInheritedWithoutType({
    required this.navigator,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(
      covariant _ContextedNavigatorInheritedWithoutType oldWidget) {
    return navigator != oldWidget.navigator;
  }
}

class ContextedNavigatorProvider<Event extends NavigationEvent>
    extends StatefulWidget {
  final ContextedNavigatorDelegate<Event> Function(BuildContext context)
      createDelegate;
  final WidgetBuilder builder;

  const ContextedNavigatorProvider({
    Key? key,
    required this.createDelegate,
    required this.builder,
  }) : super(key: key);

  factory ContextedNavigatorProvider.container({
    Key? key,
    required ContextedNavigatorDelegate<Event> Function(BuildContext context)
        createDelegate,
  }) {
    return ContextedNavigatorProvider(
      createDelegate: createDelegate,
      builder: (_) => ContextedNavigationContainer<Event>(),
    );
  }

  static ContextedNavigator<Event>? of<Event extends NavigationEvent>(
      BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
            _ContextedNavigatorInherited<Event>>()
        ?.navigator;
  }

  @override
  _ContextedNavigatorProviderState<Event> createState() =>
      _ContextedNavigatorProviderState<Event>(createDelegate);
}

class _ContextedNavigatorProviderState<Event extends NavigationEvent>
    extends State<ContextedNavigatorProvider> {
  _ContextedNavigator<Event>? navigator;
  NavigatorStack? stack;
  late ContextedNavigatorDelegate<Event> _delegate;
  final ContextedNavigatorDelegate<Event> Function(BuildContext context)
      createDelegate;

  _ContextedNavigatorProviderState(this.createDelegate);

  @override
  void didChangeDependencies() {
    if (navigator == null) {
      /// находим родительский навигатор если такой есть
      final parentNavigator = context
          .dependOnInheritedWidgetOfExactType<
              _ContextedNavigatorInheritedWithoutType>()
          ?.navigator;

      /// начальная инициализация навигатора и его зависимостей
      _delegate = createDelegate(context);

      /// слушаем нотифаер диплинка родительского навигатора
      parentNavigator?._deepLinkNotifier.addListener(_parentUriListener);

      /// выполняем первый колбэк для проверки запущенного диплинка
      if (parentNavigator != null &&
          parentNavigator._deepLinkNotifier.value != null &&
          parentNavigator._deepLinkNotifier.value!.isNotEmpty) {
        final deepPages = _delegate.mapDeepLinkToPages(
          parentNavigator._deepLinkNotifier.value!,
          [],
        );
        navigator = _ContextedNavigator<Event>(
          delegate: _delegate,
          initialPages: deepPages.isEmpty ? _delegate.initialPages : deepPages,
        );
      } else {
        navigator = _ContextedNavigator<Event>(
          delegate: _delegate,
          initialPages: _delegate.initialPages,
        );
      }

      /// устанавливаем делегату ссылку на текущий навигатор
      _delegate._navigator = navigator!;

      stack = NavigatorStack.of(context);

      /// если есть родительский навигатор сетим делегату и его
      _delegate._parentNavigator = parentNavigator;

      /// устанавливаем текущему навигатору ссылку на родительский навигатор
      navigator!._parentNavigator = parentNavigator;

      /// создаем дочерний стек
      if (parentNavigator != null) {
        NavigatorStack.of(context)
            ?.findStack(parentNavigator.runtimeType)
            ?._add(navigator!);
      }
    }
    _notifyActive();
    super.didChangeDependencies();
  }

  /// определяем активность навигатора
  /// если пейдж в котором содержится навигатор в верху стека
  /// то этот навигатор активный
  /// если наоборот то сообщаем всем дочерним стекам
  /// что они тоже не активны
  void _notifyActive() {
    for (var child in stack?.children ?? <NavigatorStack>[]) {
      if (child.navigator == navigator) {
        child._isActive = ModalRoute.of(context)?.isCurrent ?? false;
        _notifyActivePages(child.children);
        break;
      }
    }
  }

  /// рекурсия для оповещения дочерних навигаторов
  void _notifyActivePages(List<NavigatorStack> children) {
    for (var child in children) {
      child._isActive = ModalRoute.of(context)?.isCurrent ?? false;
      _notifyActivePages(child._children);
    }
  }

  /// слушатель диплинка родительского навигатора
  void _parentUriListener() {
    if (navigator?._parentNavigator?._deepLinkNotifier.value != null) {
      navigator!
          .startDeepLink(navigator!._parentNavigator!._deepLinkNotifier.value!);
    }
  }

  @override
  void dispose() {
    if (navigator != null) {
      navigator!.close();
      navigator!._parentNavigator?._deepLinkNotifier
          .removeListener(_parentUriListener);

      /// удаляем навигатор из стека
      stack?._remove(navigator!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (stack == null) {
      /// если этот провайдер первый в древе приложения
      /// создаем стэк провайдер и обработчик системной кнопки назад
      return _NavigatorStackProvider(
        create: () => NavigatorStack(navigator: navigator!),
        child: Builder(
          builder: (context) => WillPopScope(
            /// находим навигатор который лежит вверху стека
            /// передаем ему стандартный эвент
            onWillPop: () async {
              final last = NavigatorStack.of(context)
                  ?._findLastActiveStack()
                  ?._navigator;
              last?.add(NavigationWillPopEvent());
              return false;
            },
            child: _ContextedNavigatorInheritedWithoutType(
              navigator: navigator!,
              child: _ContextedNavigatorInherited<Event>(
                navigator: navigator!,
                child: Builder(
                  builder: widget.builder,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return _ContextedNavigatorInheritedWithoutType(
      navigator: navigator!,
      child: _ContextedNavigatorInherited<Event>(
        navigator: navigator!,
        child: Builder(
          builder: widget.builder,
        ),
      ),
    );
  }
}
