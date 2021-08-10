import 'package:flutter/material.dart';
import 'package:navigator_example/main/main_entry.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contexted Navigator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainEntryPoint(),
    );
  }
}
