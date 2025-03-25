import 'package:nevis/features/domain/entities/adress_entity.dart';

class AdressModel extends AddressEntity {
  final String? city;
  final String? street;
  final String? building;
  final String? apartment;

  const AdressModel({
    this.city,
    this.street,
    this.building,
    this.apartment,
  });

  factory AdressModel.fromJson(Map<String, dynamic> json) {
    return AdressModel(
      city: json["city"],
      street: json["street"],
      building: json["building"],
      apartment: json["apartment"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "street": street,
      "building": building,
      "apartment": apartment,
    };
  }
}