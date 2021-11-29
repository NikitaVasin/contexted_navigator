import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/tabs/tabs_navigator.dart';

class TabsEntryPoint extends StatelessWidget {
  final VoidCallback? onSettingsClick;

  const TabsEntryPoint({
    Key? key,
    this.onSettingsClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContextedNavigatorProvider<TabsChangeEvent>.container(
      createDelegate: (_) => TabsNavigator(),
    );
  }
}
