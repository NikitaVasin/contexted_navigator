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
  CustomMaterialPage _getTab(int index) {
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
  List<CustomMaterialPage> get initialPages => [_getTab(0)];

  @override
  List<CustomMaterialPage> mapWillPopToPages(List<CustomMaterialPage> pages) {
    parentNavigator?.pop();
    return pages;
  }

  @override
  List<CustomMaterialPage> mapEventToPages(
    TabsChangeEvent event,
    List<CustomMaterialPage> pages,
  ) {
    return pages.where((element) {
      final isNotEqual = element.key != ValueKey(event.index);
      return isNotEqual;
    }).toList()
      ..add(_getTab(event.index));
  }
}
