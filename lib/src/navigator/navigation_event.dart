part of 'contexted_navigator.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

/// эквивалент нажатия на системную кнопку назад
class NavigationWillPopEvent extends NavigationEvent {
  final Object? args;

  NavigationWillPopEvent({this.args});

  @override
  List<Object?> get props => [args];
}

/// принудительно обновляет стек страниц в навигаторе
class NavigationPageChangeEvent extends NavigationEvent {
  final List<CustomMaterialPage> pages;

  NavigationPageChangeEvent(this.pages);

  @override
  List<Object?> get props => [pages];
}

/// запускает диплинк
class NavigationDeepLinkEvent extends NavigationEvent {
  final String uri;

  NavigationDeepLinkEvent(this.uri);

  @override
  List<Object?> get props => [uri];
}
