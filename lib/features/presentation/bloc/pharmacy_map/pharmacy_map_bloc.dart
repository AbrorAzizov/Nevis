import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/models/map_marker_model.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

part 'pharmacy_map_event.dart';
part 'pharmacy_map_state.dart';

class PharmacyMapBloc extends Bloc<PharmacyMapEvent, PharmacyMapState> {
  PharmacyMapBloc() : super(PharmacyMapState()) {
    on<InitPharmacyMapEvent>((event, emit) {
      emit(PharmacyMapState(points: event.points));
      add(UpdatePharmacyMapEvent());
    });
    on<AttachControllerEvent>((event, emit) {
      emit(state.copyWith(mapController: event.mapController));
      event.mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          const CameraPosition(
              target: Point(
                  latitude: 59.946193391466124, longitude: 30.352824011619802),
              zoom: 12),
        ),
      );
    });
    on<SelectMarkerEvent>(_onSelectMarker);
    on<UpdatePharmacyMapEvent>(_onUpdateMap);
    on<ZoomInEvent>(_onZoomIn);
    on<ZoomOutEvent>(_onZoomOut);
    on<MoveToCurrentLocationEvent>(_onMoveToCurrentLocation);
  }

  void _onSelectMarker(
      SelectMarkerEvent event, Emitter<PharmacyMapState> emit) async {
    String selectedMarkerId = event.markerId ?? state.selectedMarkerId!;

    emit(state.copyWith(
      selectedMarkerId: selectedMarkerId,
      showStackWindow: state.selectedMarkerId != selectedMarkerId
          ? true
          : !state.showStackWindow,
    ));

    CameraPosition? position = await state.mapController?.getCameraPosition();

    final originalTargetPoint = state.showStackWindow
        ? state.points
            .firstWhereOrNull((e) => e.id.toString() == state.selectedMarkerId)
            ?.point
        : null;

    if (originalTargetPoint != null && position != null) {
      final shiftedTargetPoint = Point(
        latitude: originalTargetPoint.latitude - 0.002,
        longitude: originalTargetPoint.longitude,
      );

      state.mapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          position.copyWith(target: shiftedTargetPoint),
        ),
        animation: MapAnimation(duration: 0.6),
      );
    }
  }

  void _onUpdateMap(
      UpdatePharmacyMapEvent event, Emitter<PharmacyMapState> emit) async {
    List<PlacemarkMapObject> placemarks = [];

    for (MapMarkerModel point in state.points) {
      bool isSelected = point.id.toString() == state.selectedMarkerId;

      final icon =
          await Utils.createBitmapIcon(price: '', isSelected: isSelected);
      final placemark = PlacemarkMapObject(
        opacity: 1,
        mapId: MapObjectId(point.id.toString()),
        point: Point(
          latitude: point.point.latitude,
          longitude: point.point.longitude,
        ),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(image: icon),
        ),
        onTap: (point, __) =>
            add(SelectMarkerEvent(markerId: point.mapId.value)),
      );

      placemarks.add(placemark);
    }

    final clusterizedCollection = ClusterizedPlacemarkCollection(
      mapId: MapObjectId('clusterized_collection'),
      placemarks: placemarks,
      radius: 60,
      minZoom: 15,
      onClusterAdded: (self, cluster) async {
        final clusterIcon = await Utils.createBitmapIcon(count: cluster.size);
        return cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(image: clusterIcon),
            ),
          ),
        );
      },
      onClusterTap: (self, cluster) {
        add(ZoomInEvent(point: cluster.appearance.point));
      },
    );

    // ❗ Перезаписываем markers
    emit(state.copyWith(markers: [clusterizedCollection]));
  }

  Future _onZoomIn(ZoomInEvent event, Emitter<PharmacyMapState> emit) async {
    CameraPosition? position = await state.mapController?.getCameraPosition();
    final targetPoint = state.showStackWindow
        ? state.points
            .firstWhereOrNull((e) => e.id.toString() == state.selectedMarkerId)
            ?.point
        : null;
    if (position != null) {
      state.mapController?.moveCamera(
          CameraUpdate.newCameraPosition(
            position.copyWith(
                zoom: position.zoom + 1, target: event.point ?? targetPoint),
          ),
          animation: MapAnimation(duration: 0.6));
    }
  }

  Future _onZoomOut(ZoomOutEvent event, Emitter<PharmacyMapState> emit) async {
    CameraPosition? position = await state.mapController?.getCameraPosition();
    final targetPoint = state.showStackWindow
        ? state.points
            .firstWhereOrNull((e) => e.id.toString() == state.selectedMarkerId)
            ?.point
        : null;
    if (position != null) {
      state.mapController?.moveCamera(
          CameraUpdate.newCameraPosition(
            position.copyWith(zoom: position.zoom - 1, target: targetPoint),
          ),
          animation: MapAnimation(duration: 0.6));
    }
  }

  Future _onMoveToCurrentLocation(
      MoveToCurrentLocationEvent event, Emitter<PharmacyMapState> emit) async {
    CameraPosition? position = await state.mapController?.getCameraPosition();
    if (position != null) {
      state.mapController?.moveCamera(
          CameraUpdate.newCameraPosition(
            position.copyWith(
                target: Point(latitude: 53.9006, longitude: 27.5590), zoom: 12),
          ),
          animation: MapAnimation(duration: 0.6));
    }
  }
}
