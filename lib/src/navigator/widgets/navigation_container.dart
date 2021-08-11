part of '../contexted_navigator.dart';

class ContextedNavigationContainer<Event extends NavigationEvent>
    extends StatelessWidget {
  const ContextedNavigationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ContextedNavigator<Event>, NavigationState>(
      bloc: _ContextedNavigator._of<Event>(context),
      builder: (_, state) {
        return Navigator(
          pages: state.pages,
          onPopPage: (route, result) {
            _ContextedNavigator._of<Event>(context)?.pop();
            return route.didPop(result);
          },
        );
      },
    );
  }
}

class ContextedNavigationListenableBuilder<Event extends NavigationEvent>
    extends StatelessWidget {
  final Widget Function(BuildContext context, List<Page> pageKeys) builder;

  const ContextedNavigationListenableBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ContextedNavigator<Event>, NavigationState>(
      bloc: _ContextedNavigator._of<Event>(context),
      builder: (context, state) {
        return builder(context, state.pages);
      },
    );
  }
}
