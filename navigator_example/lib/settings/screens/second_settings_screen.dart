import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/settings/settings_navigator.dart';

class SecondSettingsScreen extends StatelessWidget {
  const SecondSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () =>
              ContextedNavigatorProvider.of<SettingsEvent>(context)?.pop(),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Second settings screen"),
          ],
        ),
      ),
    );
  }
}
