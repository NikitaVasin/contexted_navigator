import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/main/main_navigator.dart';

class MainEntryPoint extends StatelessWidget {
  MainEntryPoint({Key? key}) : super(key: key);

  final ValueNotifier<String?> _link =
      ValueNotifier('settings/first?id=123:second');

  @override
  Widget build(BuildContext context) {
    return ContextedNavigatorProvider<MainEvent>(
      createDelegate: (_) => MainNavigator(),
      builder: (context) => Material(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            TextFormField(
              initialValue: _link.value,
              onChanged: (text) => _link.value = text,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => NavigatorStack.of(context)?.log(),
                  child: Text('Log stack'),
                ),
                TextButton(
                  onPressed: _link.value != null
                      ? () => ContextedNavigatorProvider.of<MainEvent>(context)
                          ?.startDeepLink(_link.value!)
                      : null,
                  child: Text('Start deepLink'),
                ),
              ],
            ),
            Expanded(
              child: Scaffold(
                body: ContextedNavigationContainer<MainEvent>(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
