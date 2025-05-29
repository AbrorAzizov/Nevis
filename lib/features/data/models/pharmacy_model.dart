import 'dart:convert';

import 'package:nevis/features/domain/entities/pharmacy_entity.dart';

class PharmacyModel extends PharmacyEntity {
  const PharmacyModel({
    super.pharmacyId,
    super.title,
    super.alias,
    super.address,
    super.coordinates,
    super.schedule,
    super.metro,
    super.optics,
    super.discounter,
    super.roundtheclock,
    super.iconHref,
    super.phone,
    super.brand,
    super.textCloseTime,
    super.classCloseTime,
    super.storeId,
    super.storeXmlId,
    super.gpsN,
    super.gpsS,
    super.amounts,
    super.ufRegion,
    super.sum,
    super.raspisanie,
    super.cartAvailable,
  });

  factory PharmacyModel.fromRawJson(String str) =>
      PharmacyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    print(json['AMOUNTS']?['TEXT']);
    return PharmacyModel(
      pharmacyId: int.tryParse(json["storeId"]?.toString() ?? ''),
      title: json["TITLE"],
      alias: json["alias"],
      address: json["address"],
      coordinates: json["coordinates"]?.toString(),
      schedule: json["workTime"],
      metro: json["metro"],
      optics: json["optics"] is int
          ? json["optics"]
          : int.tryParse(json["optics"]?.toString() ?? ''),
      discounter: json["discounter"] is int
          ? json["discounter"]
          : int.tryParse(json["discounter"]?.toString() ?? ''),
      roundtheclock: json["roundtheclock"] is int
          ? json["roundtheclock"]
          : int.tryParse(json["roundtheclock"]?.toString() ?? ''),
      iconHref: json["iconHref"],
      phone: json["phone"],
      brand: json["brand"],
      textCloseTime: json["textCloseTime"],
      classCloseTime: json["classCloseTime"],
      storeId: int.tryParse(json["storeId"]?.toString() ?? ''),
      storeXmlId: json["storeXmlId"],
      gpsN: parseDouble(json["GPS_N"]),
      gpsS: parseDouble(json["GPS_S"]),
      ufRegion: json["UF_REGION"],
      sum: json["SUM"] is Map<String, dynamic> ? json["SUM"] : null,
      raspisanie: (json["raspisanie"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      cartAvailable: json['AMOUNTS']?['TEXT'] ?? json['cartAvailable'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "storeId": pharmacyId,
        "title": title,
        "alias": alias,
        "address": address,
        "coordinates": coordinates,
        "workTime": schedule,
        "metro": metro,
        "optics": optics,
        "discounter": discounter,
        "roundtheclock": roundtheclock,
        "iconHref": iconHref,
        "phone": phone,
        "brand": brand,
        "textCloseTime": textCloseTime,
        "classCloseTime": classCloseTime,
        "storeXmlId": storeXmlId,
        "GPS_N": gpsN,
        "GPS_S": gpsS,
        "amounts": amounts,
        "UF_REGION": ufRegion,
        "sum": sum,
        "raspisanie": raspisanie,
        "cartAvailable": cartAvailable,
      };
}
