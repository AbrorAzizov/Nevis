part of 'product_filter_bloc.dart';

abstract class ProductFilterEvent extends Equatable {
  const ProductFilterEvent();

  @override
  List<Object?> get props => [];
}

class ChangePriceEvent extends ProductFilterEvent {
  final double? newPrice;
  final bool? isMinPrice;
  const ChangePriceEvent(this.newPrice, this.isMinPrice);

  @override
  List<Object?> get props => [newPrice, isMinPrice ?? false];
}

class SelectReleaseFormEvent extends ProductFilterEvent {
  final int releaseFormId;
  final bool? isChecked;
  const SelectReleaseFormEvent(this.releaseFormId, this.isChecked);

  @override
  List<Object> get props => [releaseFormId, isChecked ?? false];
}

class SelectManufacturerEvent extends ProductFilterEvent {
  final int manufacturerId;
  final bool? isChecked;
  const SelectManufacturerEvent(this.manufacturerId, this.isChecked);

  @override
  List<Object> get props => [manufacturerId, isChecked ?? false];
}

class SelectCountryEvent extends ProductFilterEvent {
  final int countryId;
  final bool? isChecked;
  const SelectCountryEvent(this.countryId, this.isChecked);

  @override
  List<Object> get props => [countryId, isChecked ?? false];
}

class ToggleWithoutPrescriptionEvent extends ProductFilterEvent {
  final bool? isWithoutPrescription;
  const ToggleWithoutPrescriptionEvent(this.isWithoutPrescription);

  @override
  List<Object?> get props => [isWithoutPrescription];
}

class ToggleParticipatesInCampaignEvent extends ProductFilterEvent {
  final bool? isParticipatesInCampaign;
  const ToggleParticipatesInCampaignEvent(this.isParticipatesInCampaign);

  @override
  List<Object?> get props => [isParticipatesInCampaign];
}

class ToggleDeliveryPossibleEvent extends ProductFilterEvent {
  final bool? isDeliveryPossible;
  const ToggleDeliveryPossibleEvent(this.isDeliveryPossible);

  @override
  List<Object?> get props => [isDeliveryPossible];
}

class ClearEvent extends ProductFilterEvent {
  const ClearEvent();

  @override
  List<Object> get props => [];
}

class LoadFilterDataEvent extends ProductFilterEvent {
  final int categoryId;
  const LoadFilterDataEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
