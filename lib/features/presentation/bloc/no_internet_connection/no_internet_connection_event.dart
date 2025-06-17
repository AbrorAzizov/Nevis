part of 'no_internet_connection_bloc.dart';

abstract class NoInternetConnectionEvent extends Equatable {
  const NoInternetConnectionEvent();

  @override
  List<Object?> get props => [];
}

class LoadDataEvent extends NoInternetConnectionEvent {}
