import 'package:equatable/equatable.dart';

class PharmacyEntity extends Equatable {
  final int? pharmacyId;
  final String? alias;
  final String? address;
  final String? coordinates;
  final String? schedule;

  const PharmacyEntity({
    this.pharmacyId,
    this.alias,
    this.address,
    this.coordinates,
    this.schedule,
  });

  PharmacyEntity copyWith({
    int? pharmacyId,
    String? pageTitle,
    String? alias,
    String? address,
    String? coordinates,
    String? image,
    bool? isFavorite,
    String? schedule,
  }) =>
      PharmacyEntity(
        pharmacyId: pharmacyId ?? this.pharmacyId,
        alias: alias ?? this.alias,
        address: address ?? this.address,
        coordinates: coordinates ?? this.coordinates,
        schedule: schedule ?? this.schedule,
      );

  @override
  List<Object?> get props => [
        pharmacyId,
        alias,
        address,
        coordinates,
        schedule,
      ];
}
