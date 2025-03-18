import 'dart:convert';

import 'package:nevis/features/domain/entities/pharmacy_entity.dart';


class PharmacyModel extends PharmacyEntity {
  final int? pharmacyId;
  final String? pageTitle;
  final String? alias;
  final String? address;
  final String? coordinates;
  final String? image;
  final String? schedule;
  final bool? isFavourite; 

  const PharmacyModel({
    this.pharmacyId,
    this.isFavourite,
    this.pageTitle,
    this.alias,
    this.address,
    this.coordinates,
    this.image,
    this.schedule,
  }) : super(
          pharmacyId: pharmacyId,
          pageTitle: pageTitle,
          alias: alias,
          address: address,
          coordinates: coordinates,
          image: image,
          schedule: schedule,
          isFavourite: isFavourite
          
        );

  factory PharmacyModel.fromRawJson(String str) =>
      PharmacyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PharmacyModel.fromJson(Map<String, dynamic> json) => PharmacyModel(
        pharmacyId: json["pharmacy_id"],
        pageTitle: json["pagetitle"],
        alias: json["alias"],
        address: json["address"],
        coordinates: json["coordinates"],
        image: json["image"],
        schedule: json["schedule"],
      );

  Map<String, dynamic> toJson() => {
        "pharmacy_id": pharmacyId,
        "pagetitle": pageTitle,
        "alias": alias,
        "address": address,
        "coordinates": coordinates,
        "image": image,
        "schedule": schedule,
        "isFavourite" : isFavourite,
      };
}
