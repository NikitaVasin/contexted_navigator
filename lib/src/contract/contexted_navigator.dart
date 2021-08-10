import '../navigator/contexted_navigator.dart';

/// Интерфейс навигатора
abstract class ContextedNavigator<Event extends NavigationEvent> {
  /// добавление новго эвента в навигатор
  void addEvent(Event event);
  
  /// закрыть страницу
  void pop();

  /// запуск диплинка (в конексте древа этого навигатора)
  void startDeepLink(String uri);

  /// список обработчиков евентов
  List<ContextedNavigatorInterceptor> get interceptors;

  void addInterceptor(ContextedNavigatorInterceptor interceptor);

  void clearInterceptors();
}
