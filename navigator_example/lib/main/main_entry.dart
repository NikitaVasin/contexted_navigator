import 'package:contexted_navigator/contexted_navigator.dart';
import 'package:flutter/material.dart';
import 'package:navigator_example/main/main_navigator.dart';

class MainEntryPoint extends StatelessWidget {
  const MainEntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContextedNavigatorProvider<MainEvent>(
      createDelegate: (_) => MainNavigator(),
      builder: (context) => Scaffold(
        body: ContextedNavigationContainer<MainEvent>(),
        bottomNavigationBar: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => NavigatorStack.of(context)?.log(),
                child: Text('Log stack'),
              ),
              TextButton(
                onPressed: () => ContextedNavigatorProvider.of<MainEvent>(context)
                    ?.startDeepLink('/login:settings/first?id=123:second'),
                child: Text('Start deepLink'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
