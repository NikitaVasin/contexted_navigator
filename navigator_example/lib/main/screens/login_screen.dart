import 'package:flutter/material.dart';
import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:navigator_example/main/main_navigator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login screen'),
            TextField(),
            TextButton(
              onPressed: () => ContextedNavigatorProvider.of<MainEvent>(context)
                  ?.addEvent(MainTabsEvent()),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
