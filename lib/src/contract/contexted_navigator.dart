import 'package:flutter/material.dart';

import '../navigator/contexted_navigator.dart';

/// Интерфейс навигатора
abstract class ContextedNavigator<Event extends NavigationEvent> {
  List<Page> get pages;

  /// добавление новго эвента в навигатор
  void addEvent(Event event);

  /// закрыть страницу
  void pop();

  /// принудительно обновить список страниц навигатора
  void pushPages(List<Page> pages);

  /// запуск диплинка (в рутовом навигаторе)
  void startDeepLink(String uri);

  /// запуск диплинка (в конексте древа этого навигатора)
  void startLocalDeepLink(String uri);

  /// список обработчиков евентов
  List<ContextedNavigatorInterceptor> get interceptors;

  void addInterceptor(ContextedNavigatorInterceptor interceptor);

  void clearInterceptors();
}
