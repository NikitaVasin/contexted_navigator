import 'package:flutter/material.dart';

class NoAnimationPage extends Page<dynamic> {
  const NoAnimationPage({
    required LocalKey key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Route<dynamic> createRoute(BuildContext context) => PageRouteBuilder<dynamic>(
        settings: this,
        pageBuilder: (_, __, ___) =>
            child,
      );
}