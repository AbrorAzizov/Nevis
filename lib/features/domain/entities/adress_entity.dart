import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String? city;
  final String? street;
  final String? building;
  final String? apartment;
  final String? entrance;
  final String? floor;
  final String? intercom;
  final String? comment;

  const AddressEntity({
    this.city,
    this.street,
    this.building,
    this.apartment,
    this.entrance,
    this.floor,
    this.intercom,
    this.comment,
  });

  AddressEntity copyWith({
    String? city,
    String? street,
    String? building,
    String? apartment,
    String? entrance,
    String? floor,
    String? intercom,
    String? comment,
  }) {
    return AddressEntity(
      city: city ?? this.city,
      street: street ?? this.street,
      building: building ?? this.building,
      apartment: apartment ?? this.apartment,
      entrance: entrance ?? this.entrance,
      floor: floor ?? this.floor,
      intercom: intercom ?? this.intercom,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props => [
        city,
        street,
        building,
        apartment,
        entrance,
        floor,
        intercom,
        comment,
      ];
}
