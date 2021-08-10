import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/settings/settings_navigator.dart';

class SettingsEntryPoint extends StatelessWidget {
  const SettingsEntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContextedNavigatorProvider<SettingsEvent>.container(
      createDelegate: (_) => SettingsNavigator(),
    );
  }
}
