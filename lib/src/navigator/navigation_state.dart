part of 'contexted_navigator.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object?> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigationUpdate extends NavigationState {
  final List<Page> pages;

  NavigationUpdate(this.pages);

  @override
  List<Object?> get props => [pages];
}
