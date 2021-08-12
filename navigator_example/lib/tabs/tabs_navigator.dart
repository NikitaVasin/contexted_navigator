import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/tab_c/tab_c_entry.dart';
import 'package:navigator_example/tabs/screens/tab_a_screen.dart';
import 'package:navigator_example/tabs/screens/tab_b_screen.dart';

class TabsChangeEvent extends NavigationEvent {
  final int index;

  TabsChangeEvent(this.index);

  @override
  List<Object?> get props => [];
}

class TabsNavigator extends ContextedNavigatorDelegate<TabsChangeEvent> {
  Page _getTab(int index) {
    switch (index) {
      case 0:
        return CustomMaterialPage(
          key: ValueKey(index),
          child: TabAScreen(),
        );
      case 1:
        return CustomMaterialPage(
          key: ValueKey(index),
          child: TabBScreen(),
        );
      default:
        return CustomMaterialPage(
          key: ValueKey(index),
          child: TabCEntryPoint(),
        );
    }
  }

  @override
  List<Page> get initialPages => [_getTab(0)];

  @override
  List<Page> mapWillPopToPages(List<Page> pages) {
    parentNavigator?.pop();
    return pages;
  }

  @override
  List<Page> mapEventToPages(
    TabsChangeEvent event,
    List<Page> pages,
  ) {
    return pages.where((element) {
      final isNotEqual = element.key != ValueKey(event.index);
      return isNotEqual;
    }).toList()
      ..add(_getTab(event.index));
  }
}
