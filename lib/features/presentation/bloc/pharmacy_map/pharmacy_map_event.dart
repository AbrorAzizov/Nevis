part of 'pharmacy_map_bloc.dart';

abstract class PharmacyMapEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitPharmacyMapEvent extends PharmacyMapEvent {
  final List<MapMarkerModel> points;
  InitPharmacyMapEvent({required this.points});
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

class ClusterTappedEvent extends PharmacyMapEvent {
  final Cluster cluster;
  ClusterTappedEvent({required this.cluster});
}
