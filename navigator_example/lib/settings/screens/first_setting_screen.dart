import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/settings/settings_navigator.dart';

class FirstSettingsScreen extends StatelessWidget {
  final String? id;

  const FirstSettingsScreen({Key? key, this.id}) : super(key: key);

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
            Hero(
              tag: 'settings',
              child: Icon(
                Icons.settings,
                size: 100,
              ),
            ),
            Text("First settings screen"),
            if (id != null) Text(id!),
            TextField(),
            TextButton(
              onPressed: () =>
                  ContextedNavigatorProvider.of<SettingsEvent>(context)
                      ?.addEvent(SettingsSecondEvent()),
              child: Text('go to second'),
            ),
          ],
        ),
      ),
    );
  }
}
