import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class RouteObserverEvent extends Equatable {
  const RouteObserverEvent();
}

class RouteChanged extends RouteObserverEvent {
  final String? routeName;

  const RouteChanged(this.routeName);

  @override
  List<Object?> get props => [routeName];
}

abstract class RouteObserverState extends Equatable {
  const RouteObserverState();
}

class RouteObserverInitial extends RouteObserverState {
  @override
  List<Object?> get props => [];
}

class RouteUpdated extends RouteObserverState {
  final String? routeName;

  const RouteUpdated(this.routeName);

  @override
  List<Object?> get props => [routeName];
}

// RouteObserverBloc
class RouteObserverBloc extends Bloc<RouteObserverEvent, RouteObserverState> {
  RouteObserverBloc() : super(RouteObserverInitial()) {
    on<RouteChanged>((event, emit) {
      emit(RouteUpdated(event.routeName));
    });
  }
}
