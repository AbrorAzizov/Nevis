import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';

class PharmacyEntity extends Equatable {
  final int? pharmacyId;
  final String? title;
  final String? alias;
  final String? address;
  final String? coordinates;
  final String? schedule;
  final String? metro;
  final int? optics;
  final int? discounter;
  final int? roundtheclock;
  final String? iconHref;
  final String? phone;
  final String? brand;
  final String? textCloseTime;
  final String? classCloseTime;
  final int? storeId;
  final String? storeXmlId;
  final double? gpsN;
  final double? gpsS;
  final Map<String, dynamic>? amounts;
  final String? ufRegion;
  final Map<String, dynamic>? sum;
  final List<String>? raspisanie;
  final String? cartAvailableString;
  final AvailabilityCartStatus? cartStatus;

  const PharmacyEntity({
    this.cartStatus,
    this.cartAvailableString,
    this.pharmacyId,
    this.title,
    this.alias,
    this.address,
    this.coordinates,
    this.schedule,
    this.metro,
    this.optics,
    this.discounter,
    this.roundtheclock,
    this.iconHref,
    this.phone,
    this.brand,
    this.textCloseTime,
    this.classCloseTime,
    this.storeId,
    this.storeXmlId,
    this.gpsN,
    this.gpsS,
    this.amounts,
    this.ufRegion,
    this.sum,
    this.raspisanie,
  });

  @override
  List<Object?> get props => [
        pharmacyId,
        title,
        alias,
        address,
        coordinates,
        schedule,
        metro,
        optics,
        discounter,
        roundtheclock,
        iconHref,
        phone,
        brand,
        textCloseTime,
        classCloseTime,
        storeId,
        storeXmlId,
        gpsN,
        gpsS,
        amounts,
        ufRegion,
        sum,
        raspisanie,
      ];
}
