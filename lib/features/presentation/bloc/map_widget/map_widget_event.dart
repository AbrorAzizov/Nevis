part of 'map_widget_bloc.dart';

abstract class MapWidgetEvent extends Equatable {
  const MapWidgetEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends MapWidgetEvent {}
