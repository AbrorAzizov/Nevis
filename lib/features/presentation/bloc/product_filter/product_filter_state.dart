part of 'product_filter_bloc.dart';

class ProductFilterState extends Equatable {
  final double? minAllowedPrice;
  final double? maxAllowedPrice;
  final double? minSelectedPrice;
  final double? maxSelectedPrice;
  final List<String>? releaseForms;
  final Set<int>? selectedReleaseFormsId;
  final List<String>? manufacturers;
  final Set<int>? selectedManufacturersId;
  final List<String>? countries;
  final Set<int>? selectedCountriesId;

  final bool? isWithoutPrescription;
  final bool? isParticipatesInCampaign;
  final bool? isDeliveryPossible;

  final bool? isLoading;

  const ProductFilterState({
    this.minAllowedPrice,
    this.maxAllowedPrice,
    this.minSelectedPrice,
    this.maxSelectedPrice,
    this.releaseForms,
    this.selectedReleaseFormsId,
    this.manufacturers,
    this.selectedManufacturersId,
    this.countries,
    this.selectedCountriesId,
    this.isWithoutPrescription,
    this.isParticipatesInCampaign,
    this.isDeliveryPossible,
    this.isLoading = true,
  });

  ProductFilterState copyWith({
    double? minAllowedPrice,
    double? maxAllowedPrice,
    double? minSelectedPrice,
    double? maxSelectedPrice,
    List<String>? releaseForms,
    Set<int>? selectedReleaseFormsId,
    List<String>? manufacturers,
    Set<int>? selectedManufacturersId,
    List<String>? countries,
    Set<int>? selectedCountriesId,
    bool? isWithoutPrescription,
    bool? isParticipatesInCampaign,
    bool? isDeliveryPossible,
    bool? isLoading,
  }) {
    return ProductFilterState(
      minAllowedPrice: minAllowedPrice ?? this.minAllowedPrice,
      maxAllowedPrice: maxAllowedPrice ?? this.maxAllowedPrice,
      minSelectedPrice: minSelectedPrice ?? this.minSelectedPrice,
      maxSelectedPrice: maxSelectedPrice ?? this.maxSelectedPrice,
      releaseForms: releaseForms ?? this.releaseForms,
      selectedReleaseFormsId:
          selectedReleaseFormsId ?? this.selectedReleaseFormsId,
      manufacturers: manufacturers ?? this.manufacturers,
      selectedManufacturersId:
          selectedManufacturersId ?? this.selectedManufacturersId,
      countries: countries ?? this.countries,
      selectedCountriesId: selectedCountriesId ?? this.selectedCountriesId,
      isWithoutPrescription:
          isWithoutPrescription ?? this.isWithoutPrescription,
      isParticipatesInCampaign:
          isParticipatesInCampaign ?? this.isParticipatesInCampaign,
      isDeliveryPossible: isDeliveryPossible ?? this.isDeliveryPossible,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        minAllowedPrice,
        maxAllowedPrice,
        minSelectedPrice,
        maxSelectedPrice,
        releaseForms,
        selectedReleaseFormsId,
        manufacturers,
        selectedManufacturersId,
        countries,
        selectedCountriesId,
        isWithoutPrescription,
        isParticipatesInCampaign,
        isDeliveryPossible,
        isLoading,
      ];
}
