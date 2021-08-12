import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/tab_c/screens/tab_c_first_screen.dart';
import 'package:navigator_example/tab_c/screens/tab_c_second.dart';

abstract class TabCEvent extends NavigationEvent {}

class TabCInitialEvent extends TabCEvent {}

class TabCSecondEvent extends TabCEvent {}

class TabCNavigator extends ContextedNavigatorDelegate<TabCEvent> {
  Page get _firstPage => CustomMaterialPage(
        key: ValueKey('first'),
        child: TabCFirstScreen(),
      );

  Page get _secondPage => CustomMaterialPage(
        key: ValueKey('second'),
        child: TabCSecondScreen(),
      );

  @override
  List<Page> get initialPages => [_firstPage];

  @override
  List<Page> mapEventToPages(
    TabCEvent event,
    List<Page> pages,
  ) {
    if (event is TabCInitialEvent) {
      return pages..add(_firstPage);
    } else if (event is TabCSecondEvent) {
      return pages..add(_secondPage);
    }
    return pages;
  }
}
