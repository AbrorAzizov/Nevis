part of 'search_screen_bloc.dart';

abstract class SearchScreenEvent extends Equatable {
  const SearchScreenEvent();

  @override
  List<Object?> get props => [];
}

class ChangePriceEvent extends SearchScreenEvent {
  final double? newPrice;
  final bool? isMinPrice;
  const ChangePriceEvent(this.newPrice, this.isMinPrice);

  @override
  List<Object?> get props => [newPrice, isMinPrice ?? false];
}

class SelectReleaseFormEvent extends SearchScreenEvent {
  final int releaseFormId;
  final bool? isChecked;
  const SelectReleaseFormEvent(this.releaseFormId, this.isChecked);

  @override
  List<Object> get props => [releaseFormId, isChecked ?? false];
}

class SelectManufacturerEvent extends SearchScreenEvent {
  final int manufacturerId;
  final bool? isChecked;
  const SelectManufacturerEvent(this.manufacturerId, this.isChecked);

  @override
  List<Object> get props => [manufacturerId, isChecked ?? false];
}

class SelectCountryEvent extends SearchScreenEvent {
  final int countryId;
  final bool? isChecked;
  const SelectCountryEvent(this.countryId, this.isChecked);

  @override
  List<Object> get props => [countryId, isChecked ?? false];
}

class ToggleWithoutPrescriptionEvent extends SearchScreenEvent {
  final bool? isWithoutPrescription;
  const ToggleWithoutPrescriptionEvent(this.isWithoutPrescription);

  @override
  List<Object?> get props => [isWithoutPrescription];
}

class ToggleParticipatesInCampaignEvent extends SearchScreenEvent {
  final bool? isParticipatesInCampaign;
  const ToggleParticipatesInCampaignEvent(this.isParticipatesInCampaign);

  @override
  List<Object?> get props => [isParticipatesInCampaign];
}

class ToggleDeliveryPossibleEvent extends SearchScreenEvent {
  final bool? isDeliveryPossible;
  const ToggleDeliveryPossibleEvent(this.isDeliveryPossible);

  @override
  List<Object?> get props => [isDeliveryPossible];
}

class ClearEvent extends SearchScreenEvent {
  const ClearEvent();

  @override
  List<Object> get props => [];
}

class ToggleExpandCollapseEvent extends SearchScreenEvent {
  final bool isExpanded;
  const ToggleExpandCollapseEvent(this.isExpanded);

  @override
  List<Object?> get props => [isExpanded];
}

class SelectSuggestionsEvent extends SearchScreenEvent {
  final String suggestion;
  const SelectSuggestionsEvent(this.suggestion);

  @override
  List<Object?> get props => [];
}

class ChangeQueryEvent extends SearchScreenEvent {
  final String text;
  const ChangeQueryEvent(this.text);

  @override
  List<Object?> get props => [];
}

class ClearQueryEvent extends SearchScreenEvent {
  const ClearQueryEvent();

  @override
  List<Object?> get props => [];
}
