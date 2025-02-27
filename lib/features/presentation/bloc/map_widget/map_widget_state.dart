part of 'map_widget_bloc.dart';

class MapWidgetState extends Equatable {
  final bool isLoading;
  final List<MapObject<dynamic>>? mapObjects;

  const MapWidgetState({
    this.isLoading = true,
    this.mapObjects,
  });

  MapWidgetState copyWith({
    bool? isLoading,
    List<MapObject<dynamic>>? mapObjects,
  }) {
    return MapWidgetState(
      isLoading: isLoading ?? this.isLoading,
      mapObjects: mapObjects ?? this.mapObjects,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        mapObjects,
      ];
}
