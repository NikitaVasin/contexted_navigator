part of '../contexted_navigator.dart';

/// вспомогательный миксин
mixin CuperinoPopMixin<T> on PageRoute<T> {
  _ContextedNavigator? get currentNavigator;

  NavigatorStack? get stack;

  /// проверка сделана для ios чтобы при наложении навигаторов
  /// не происходило закрытие сразу нескольких страниц вместе с
  /// вложенными навигаторам
  @protected
  bool get hasScopedWillPopCallback {
    final currentStack = stack?.findStack(currentNavigator.runtimeType);
    final lastActive = stack?.findLastActive();
    if (currentStack?.isActive ?? true) {
      if ((currentNavigator ?? lastActive) != lastActive) {
        final list = currentStack?.children ?? <NavigatorStack>[];
        if (list.isNotEmpty) {
          for (var child in list) {
            if (child.isActive && child._navigator._isNavigatorAllowBack()) {
              return false;
            }
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
    return true;
  }
}

/// page для корректной работы свайпа назад
/// с вложенными навигаторами
class CustomMaterialPage<T> extends Page<T> {
  /// Creates a material page.
  const CustomMaterialPage({
    required LocalKey key,
    required this.child,
    this.allowBack = true,
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.opaque,
    this.barrierColor,
    this.barrierLabel,
    this.barrierDismissible,
    String? name,
    Object? arguments,
    String? restorationId,
  }) : super(
          key: key,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
        );

  final Widget child;

  final bool maintainState;

  final bool fullscreenDialog;

  final bool allowBack;

  final bool? opaque;

  final bool? barrierDismissible;

  final Color? barrierColor;

  final String? barrierLabel;

  @override
  Route<T> createRoute(BuildContext context) {
    return _CustomPageBasedMaterialPageRoute<T>(
      page: this,
    );
  }
}

class _CustomPageBasedMaterialPageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T>, CuperinoPopMixin<T> {
  _CustomPageBasedMaterialPageRoute({
    required CustomMaterialPage<T> page,
  }) : super(settings: page) {
    assert(opaque);
  }

  _ContextedNavigator? _currentNavigator;
  NavigatorStack? _stack;

  CustomMaterialPage<T> get _page => settings as CustomMaterialPage<T>;

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  bool get opaque => _page.opaque ?? super.opaque;

  @override
  Color? get barrierColor => _page.barrierColor ?? super.barrierColor;

  @override
  String? get barrierLabel => _page.barrierLabel ?? super.barrierLabel;

  @override
  bool get barrierDismissible =>
      _page.barrierDismissible ?? super.barrierDismissible;

  @override
  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';

  @override
  Widget buildContent(BuildContext context) {
    if (currentNavigator == null) {
      _currentNavigator = context
          .dependOnInheritedWidgetOfExactType<
              _ContextedNavigatorInheritedWithoutType>()
          ?.navigator;
    }
    if (stack == null) {
      _stack = NavigatorStack.of(context);
    }
    return _page.child;
  }

  @override
  _ContextedNavigator<NavigationEvent>? get currentNavigator =>
      _currentNavigator;

  @override
  NavigatorStack? get stack => _stack;
}
