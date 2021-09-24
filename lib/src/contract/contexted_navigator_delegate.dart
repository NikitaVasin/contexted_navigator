part of '../navigator/contexted_navigator.dart';

/// билдер для дииплинк эвентов
typedef DeepLinkPageBuilder = Future<Page> Function(
  Map<String, String> params,
);

abstract class ContextedNavigatorDelegate<Event extends NavigationEvent> {
  /// родительский навигатор
  /// может быть `null` если это корневой навигатор
  _ContextedNavigator? _parentNavigator;

  /// текущий навигатор
  late ContextedNavigator<Event> _navigator;

  ContextedNavigator? get parentNavigator => _parentNavigator;

  ContextedNavigator<Event> get navigator => _navigator;

  /// конекст текущего навигатора
  late BuildContext _navigatorContext;

  BuildContext get navigatorContext => _navigatorContext;

  /// начальный стек страниц
  List<Page> get initialPages;

  List<ContextedNavigatorInterceptor> get interceptors => [];

  /// схема диплинков навигатора
  /// стеки навигаторов разделяются `/`
  /// экраны внутри стека разделяются `:`
  /// параметры задаются через `?`
  /// пример: `main/detectives/dashboard?id=123:info?id=123`
  Map<String, DeepLinkPageBuilder> get deepLinks => {};

  HeroController? get heroController => HeroController();

  /// инициализирующий колбэк,
  /// после его вызова все поля делегата проинициализированы
  void initState() {}

  /// обработка эвентов
  List<Page> mapEventToPages(
    Event event,
    List<Page> pages,
  ) {
    return pages;
  }

  /// обработка системной кнопки назад
  List<Page> mapWillPopToPages(
    List<Page> pages,
  ) {
    if (pages.length > 1) {
      return pages..removeLast();
    } else {
      if (parentNavigator != null) {
        parentNavigator!.pop();
      } else {
        SystemNavigator.pop();
      }
      return pages;
    }
  }

  /// парсинг диплинка
  Future<List<Page>> mapDeepLinkToPages(
    String uri,
    List<Page> pages,
  ) async {
    final clearUri = uri.startsWith('/') ? uri.replaceFirst('/', '') : uri;
    final currentPath = clearUri.split('/').firstOrNull;
    final pagesPath = currentPath?.split(':');
    final newPages = <Page>[];
    for (var pagePath in pagesPath ?? <String>[]) {
      final newUri = Uri.tryParse(pagePath);
      if (deepLinks.containsKey(newUri?.path)) {
        newPages.add(
            await deepLinks[newUri?.path]!.call(newUri?.queryParameters ?? {}));

        /// если навигатор успешно обработал диплинк
        /// обнуляем нотифайер родителя, что бы стейт диплинка не сохранился
        _parentNavigator?._deepLinkNotifier.value = null;
      }
    }
    if (newPages.isNotEmpty) {
      return newPages;
    }
    return pages;
  }

  /// для определения когда можно свайпом закрыть пейдж с этим навигатором
  /// актуально только для CupertinTransition
  bool allowNavigatorSwipe(List<Page> pages) => pages.length < 2;

  Future<void> dispose() async {}
}
