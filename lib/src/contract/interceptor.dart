part of '../navigator/contexted_navigator.dart';

/// прерыватель добавления эвента в навигатор
abstract class ContextedNavigatorInterceptor {
  /// функция для принудительной доставки страниц в навигатор
  /// инитиализируется при создании навигатора
  late Function(List<Page> pages) _pushPages;

  BuildContext? _navigatorContext;

  Function(List<Page> pages) get pushPages => _pushPages;

  BuildContext? get navigatorContext => _navigatorContext;

  /// активен ли прерыватель
  bool isActive = true;

  /// если `true` доставка эвента в навигатор прерывается
  Future<bool> shouldInterrupt(
    NavigationEvent event,
    List<Page> pages,
  );
}
