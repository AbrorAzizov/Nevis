part of 'pharmacy_map_bloc.dart';

abstract class PharmacyMapEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitPharmacyMapEvent extends PharmacyMapEvent {
  final List<MapMarkerModel> points;
  final PharmacyMapType mapType;
  final Point? initPoint;
  InitPharmacyMapEvent(
      {required this.points, required this.mapType, this.initPoint});
}

class UpdatePharmacyMapMarkersEvent extends PharmacyMapEvent {
  final List<MapMarkerModel> points;
  UpdatePharmacyMapMarkersEvent({required this.points});
}

class AttachControllerEvent extends PharmacyMapEvent {
  final YandexMapController mapController;
  AttachControllerEvent({required this.mapController});
}

class ClosePharmacyMapEvent extends PharmacyMapEvent {}

class SelectMarkerEvent extends PharmacyMapEvent {
  final String? markerId;
  SelectMarkerEvent({this.markerId});
}

class UpdatePharmacyMapEvent extends PharmacyMapEvent {
  final CameraPosition? position;
  UpdatePharmacyMapEvent({this.position});
}

class ZoomInEvent extends PharmacyMapEvent {
  final Point? point;
  ZoomInEvent({this.point});
}

class ZoomOutEvent extends PharmacyMapEvent {}

class MoveToCurrentLocationEvent extends PharmacyMapEvent {}

class MoveToPointEvent extends PharmacyMapEvent {
  final Point point;
  MoveToPointEvent({required this.point});
}

class ClusterTappedEvent extends PharmacyMapEvent {
  final Cluster cluster;
  ClusterTappedEvent({required this.cluster});
}
