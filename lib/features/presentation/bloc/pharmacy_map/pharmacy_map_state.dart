part of 'pharmacy_map_bloc.dart';

class PharmacyMapState extends Equatable {
  final String? selectedMarkerId;
  final bool showStackWindow;
  final List<MapObject<dynamic>> markers;
  final PharmacyMapType? mapType;
  final List<MapMarkerModel> points;
  final YandexMapController? mapController;
  final Point userPoint;

  const PharmacyMapState({
    this.selectedMarkerId,
    this.showStackWindow = false,
    this.markers = const [],
    this.points = const [],
    this.mapController,
    this.mapType,
    this.userPoint = const Point(
        latitude: 59.946193391466124, longitude: 30.352824011619802),
  });

  PharmacyMapState copyWith({
    String? selectedMarkerId,
    bool? showStackWindow,
    List<MapObject<dynamic>>? markers,
    List<MapMarkerModel>? points,
    YandexMapController? mapController,
    bool removeController = false,
    PharmacyMapType? mapType,
    Point? userPoint,
  }) {
    return PharmacyMapState(
      showStackWindow: showStackWindow ?? this.showStackWindow,
      selectedMarkerId: selectedMarkerId ?? this.selectedMarkerId,
      markers: markers ?? this.markers,
      points: points ?? this.points,
      mapController:
          removeController ? null : mapController ?? this.mapController,
      mapType: mapType ?? this.mapType,
      userPoint: userPoint ?? this.userPoint,
    );
  }

  @override
  List<Object?> get props => [
        showStackWindow,
        selectedMarkerId,
        markers,
        points,
        mapController,
        mapType,
        userPoint
      ];
}
