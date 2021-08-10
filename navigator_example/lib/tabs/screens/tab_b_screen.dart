import 'package:flutter/material.dart';

class TabBScreen extends StatelessWidget {
  const TabBScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab B Screen'),
          ],
        ),
      ),
    );
  }
}
