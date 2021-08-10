import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/tab_c/tab_c_navigator.dart';

class TabCSecondScreen extends StatelessWidget {
  const TabCSecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab C - Second Screen'),
            TextButton(
              onPressed: () =>
                  ContextedNavigatorProvider.of<TabCEvent>(context)?.pop(),
              child: Text('back'),
            ),
          ],
        ),
      ),
    );
  }
}
