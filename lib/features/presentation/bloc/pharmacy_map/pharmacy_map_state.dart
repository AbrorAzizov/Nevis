part of 'pharmacy_map_bloc.dart';

class PharmacyMapState extends Equatable {
  final String? selectedMarkerId;
  final bool showStackWindow;
  final List<MapObject<dynamic>> markers;

  final List<MapMarkerModel> points;
  final YandexMapController? mapController;

  const PharmacyMapState({
    this.selectedMarkerId,
    this.showStackWindow = false,
    this.markers = const [],
    this.points = const [],
    this.mapController,
  });

  PharmacyMapState copyWith({
    String? selectedMarkerId,
    bool? showStackWindow,
    List<MapObject<dynamic>>? markers,
    List<MapMarkerModel>? points,
    YandexMapController? mapController,
    bool removeController = false,
  }) {
    return PharmacyMapState(
      showStackWindow: showStackWindow ?? this.showStackWindow,
      selectedMarkerId: selectedMarkerId ?? this.selectedMarkerId,
      markers: markers ?? this.markers,
      points: points ?? this.points,
      mapController:
          removeController ? null : mapController ?? this.mapController,
    );
  }

  @override
  List<Object?> get props => [
        showStackWindow,
        selectedMarkerId,
        markers,
        points,
        mapController,
      ];
}
