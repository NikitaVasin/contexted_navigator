import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/tab_c/tab_c_navigator.dart';

class TabCFirstScreen extends StatelessWidget {
  const TabCFirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab C - First Screen'),
            TextField(),
            TextButton(
              onPressed: () => ContextedNavigatorProvider.of<TabCEvent>(context)
                  ?.addEvent(TabCSecondEvent()),
              child: Text('go to second'),
            ),
          ],
        ),
      ),
    );
  }
}
