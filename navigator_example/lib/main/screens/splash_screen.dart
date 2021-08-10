import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/main/main_navigator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Splash Screen'),
            TextButton(
              onPressed: () => ContextedNavigatorProvider.of<MainEvent>(context)
                  ?.addEvent(MainLoginEvent()),
              child: Text('Go to login'),
            ),
          ],
        ),
      ),
    );
  }
}
