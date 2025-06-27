import 'package:nevis/features/domain/entities/adress_entity.dart';

class AdressModel extends AddressEntity {
  @override
  final String? city;
  @override
  final String? street;
  @override
  final String? building;
  @override
  final String? apartment;
  @override
  final String? entrance;
  @override
  final String? floor;
  @override
  final String? intercom;
  @override
  final String? comment;

  const AdressModel({
    this.city,
    this.street,
    this.building,
    this.apartment,
    this.entrance,
    this.floor,
    this.intercom,
    this.comment,
  }) : super(
          city: city,
          street: street,
          building: building,
          apartment: apartment,
          entrance: entrance,
          floor: floor,
          intercom: intercom,
          comment: comment,
        );

  factory AdressModel.fromJson(Map<String, dynamic> json) {
    return AdressModel(
      city: json["city"],
      street: json["street"],
      building: json["building"],
      apartment: json["apartment"],
      entrance: json["entrance"],
      floor: json["floor"],
      intercom: json["intercom"],
      comment: json["comment"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "street": street,
      "building": building,
      "apartment": apartment,
      "entrance": entrance,
      "floor": floor,
      "intercom": intercom,
      "comment": comment,
    };
  }
}
