import 'dart:async';

import 'package:flutter/material.dart';
import 'package:contexted_navigator/contexted_navigator.dart';


class CheckFinishInterceptor extends ContextedNavigatorInterceptor {
  Page _checkPage(
    Completer<bool> completer,
    List<Page> pages,
  ) {
    return MaterialPage(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Вы уверены что хотите покинуть экран?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      pushPages(pages);
                      completer.complete(false);
                    },
                    child: Text('Да'),
                  ),
                  TextButton(
                    onPressed: () {
                      pushPages(pages);
                      completer.complete(true);
                    },
                    child: Text('Нет'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<bool> shouldInterrupt(
    NavigationEvent event,
    List<Page> pages,
  ) async {
    if (event is NavigationWillPopEvent && pages.length < 2) {
      final completer = Completer<bool>();
      pushPages(List.of(pages)..add(_checkPage(completer, pages)));
      return completer.future;
    }
    return false;
  }
}
