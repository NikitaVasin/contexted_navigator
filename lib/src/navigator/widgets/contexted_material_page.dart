part of '../contexted_navigator.dart';

class _ContextedMaterialPageRoute<T> extends ContextedPageRoute<T>
    with MaterialRouteTransitionMixin<T>, CuperinoPopMixin<T> {
  _ContextedMaterialPageRoute({
    required CustomMaterialPage<T> page,
  }) : super(settings: page) {
    assert(opaque);
  }

  ContextedNavigator? _currentNavigator;
  NavigatorStack? _stack;

  CustomMaterialPage<T> get _page => settings as CustomMaterialPage<T>;

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';

  @override
  Widget buildContextedPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildContextedPage
    throw UnimplementedError();
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    throw UnimplementedError();
  }
}
