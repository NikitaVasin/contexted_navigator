part of '../contexted_navigator.dart';

class _NavigatorStackInherited extends InheritedWidget {
  final NavigatorStack stack;

  _NavigatorStackInherited({
    required this.stack,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant _NavigatorStackInherited oldWidget) =>
      stack != oldWidget.stack;
}

class _NavigatorStackProvider extends StatefulWidget {
  final NavigatorStack Function() create;
  final Widget child;

  const _NavigatorStackProvider({
    Key? key,
    required this.create,
    required this.child,
  }) : super(key: key);

  @override
  _NavigatorStackProviderState createState() => _NavigatorStackProviderState();
}

class _NavigatorStackProviderState extends State<_NavigatorStackProvider> {
  late NavigatorStack stack;

  @override
  void initState() {
    stack = widget.create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _NavigatorStackInherited(
      stack: stack,
      child: widget.child,
    );
  }
}