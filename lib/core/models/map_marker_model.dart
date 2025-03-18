import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class MapMarkerModel {
  final int id;
  final Point point;
  final Map<String, dynamic>? data;

  const MapMarkerModel({required this.id, required this.point, this.data});
}
