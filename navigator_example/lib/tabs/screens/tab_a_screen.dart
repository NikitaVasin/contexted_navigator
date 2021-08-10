import 'package:flutter/material.dart';

class TabAScreen extends StatelessWidget {
  const TabAScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab A Screen'),
            TextField(),
          ],
        ),
      ),
    );
  }
}
