import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/tab_c/tab_c_navigator.dart';

class TabCEntryPoint extends StatelessWidget {
  const TabCEntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContextedNavigatorProvider<TabCEvent>.container(
      createDelegate: (_) => TabCNavigator(),
    );
  }
}
