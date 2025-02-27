part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenPageChanged extends HomeScreenState {
  final int selectedPageIndex;

  const HomeScreenPageChanged(this.selectedPageIndex);

  @override
  List<Object> get props => [selectedPageIndex];
}

class InternetUnavailable extends HomeScreenState {}
