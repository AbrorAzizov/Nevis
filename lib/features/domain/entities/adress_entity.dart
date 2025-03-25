import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String? city;
  final String? street;
  final String? building;
  final String? apartment;

  const AddressEntity({
    this.city,
    this.street,
    this.building,
    this.apartment,
  });

  AddressEntity copyWith({
    String? city,
    String? street,
    String? building,
    String? apartment,
  }) =>
      AddressEntity(
        city: city ?? this.city,
        street: street ?? this.street,
        building: building ?? this.building,
        apartment: apartment ?? this.apartment,
      );

  @override
  List<Object?> get props => [city, street, building, apartment];
}