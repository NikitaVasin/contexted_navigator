part of '../navigator/contexted_navigator.dart';

/// Интерфейс навигатора
abstract class ContextedNavigator<Event extends NavigationEvent> {
  List<CustomMaterialPage> get pages;

  /// добавление новго эвента в навигатор
  void addEvent(Event event);

  /// закрыть страницу
  void pop();

  /// принудительно обновить список страниц навигатора
  void pushPages(List<CustomMaterialPage> pages);

  /// запуск диплинка (в конексте древа этого навигатора)
  void startDeepLink(String uri);

  /// список обработчиков евентов
  List<ContextedNavigatorInterceptor> get interceptors;

  void addInterceptor(ContextedNavigatorInterceptor interceptor);

  void clearInterceptors();
}
