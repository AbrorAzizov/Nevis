import 'dart:convert';

import 'package:nevis/features/domain/entities/pharmacy_entity.dart';

class PharmacyModel extends PharmacyEntity {
  const PharmacyModel({
    super.pharmacyId,
    super.alias,
    super.address,
    super.coordinates,
    super.schedule,
  });

  factory PharmacyModel.fromRawJson(String str) =>
      PharmacyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PharmacyModel.fromJson(Map<String, dynamic> json) => PharmacyModel(
        pharmacyId: json["id"],
        alias: json["name"],
        address: json["address"],
        coordinates: json["coordinates"],
        schedule: json["working_hours"],
      );

  Map<String, dynamic> toJson() => {
        "pharmacy_id": pharmacyId,
        "alias": alias,
        "address": address,
        "coordinates": coordinates,
        "schedule": schedule,
      };
}
