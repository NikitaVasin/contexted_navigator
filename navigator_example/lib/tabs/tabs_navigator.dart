import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/tabs/screens/tabs_screen.dart';

class TabsChangeEvent extends NavigationEvent {
  final int index;

  const TabsChangeEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class TabsNavigator extends ContextedNavigatorDelegate<TabsChangeEvent> {
  Page _getTab(int index) {
    return CustomMaterialPage(
      key: ValueKey('main'),
      child: TabsScreen(
        currentPage: index,
      ),
    );
  }

  @override
  List<Page> get initialPages => [_getTab(0)];

  @override
  List<Page> mapEventToPages(
    TabsChangeEvent event,
    List<Page> pages,
  ) {
    return pages
      ..removeWhere((element) => element.key == ValueKey('main'))
      ..add(_getTab(event.index));
  }
}
