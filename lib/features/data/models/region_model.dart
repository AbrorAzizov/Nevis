import 'package:nevis/features/domain/entities/region_entity.dart';

class RegionModel extends RegionEntity {
  const RegionModel({super.id, super.name, super.isDefault});
  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
        id: json['region_id'],
        name: json['region_name'],
        isDefault: json['default']);
  }
}
