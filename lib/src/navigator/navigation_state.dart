part of 'contexted_navigator.dart';

class NavigationState extends Equatable {
  final List<Page> pages;

  const NavigationState(this.pages);

  @override
  List<Object?> get props => [pages];
}
