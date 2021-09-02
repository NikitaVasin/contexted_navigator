part of '../contexted_navigator.dart';

abstract class ContextedPage<T> extends Page<T> {
  ContextedPage({
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(
    key: key ?? UniqueKey(),
    name: name,
    arguments: arguments,
    restorationId: restorationId,
  );

  ContextedPageRoute<T> createContextedRoute(BuildContext context);

  @override
  @mustCallSuper
  Route<T> createRoute(BuildContext context) {
    return createContextedRoute(context);
  }
}

abstract class ContextedPageRoute<T> extends PageRoute<T>
    with CuperinoPopMixin<T> {
  ContextedPageRoute({
    required Page<T> settings,
    bool fullscreenDialog = false,
  }) : super(
          fullscreenDialog: fullscreenDialog,
          settings: settings,
        );

  ContextedNavigator? _currentNavigator;
  NavigatorStack? _stack;

  @override
  ContextedNavigator<NavigationEvent>? get currentNavigator =>
      _currentNavigator;

  @override
  NavigatorStack? get stack => _stack;

  @override
  @mustCallSuper
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    if (currentNavigator == null) {
      _currentNavigator = context
          .dependOnInheritedWidgetOfExactType<
              ContextedNavigatorInheritedWithoutType>()
          ?.navigator;
    }
    if (stack == null) {
      _stack = NavigatorStack.of(context);
    }
    return buildContextedPage(context, animation, secondaryAnimation);
  }

  Widget buildContextedPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  );
}
