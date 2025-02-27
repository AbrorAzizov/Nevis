import 'package:equatable/equatable.dart';

class PharmacyEntity extends Equatable {
  final int? pharmacyId;
  final String? pageTitle;
  final String? alias;
  final String? address;
  final String? coordinates;
  final String? image;
  final String? schedule;

  const PharmacyEntity({
    this.pharmacyId,
    this.pageTitle,
    this.alias,
    this.address,
    this.coordinates,
    this.image,
    this.schedule,
  });

  PharmacyEntity copyWith({
    int? pharmacyId,
    String? pageTitle,
    String? alias,
    String? address,
    String? coordinates,
    String? image,
    String? schedule,
  }) =>
      PharmacyEntity(
        pharmacyId: pharmacyId ?? this.pharmacyId,
        pageTitle: pageTitle ?? this.pageTitle,
        alias: alias ?? this.alias,
        address: address ?? this.address,
        coordinates: coordinates ?? this.coordinates,
        image: image ?? this.image,
        schedule: schedule ?? this.schedule,
      );

  @override
  List<Object?> get props => [
        pharmacyId,
        pageTitle,
        alias,
        address,
        coordinates,
        image,
        schedule,
      ];
}
