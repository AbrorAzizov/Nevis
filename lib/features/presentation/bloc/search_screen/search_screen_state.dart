part of 'search_screen_bloc.dart';

class SearchScreenState extends Equatable {
  final double minAllowedPrice;
  final double maxAllowedPrice;
  final double minSelectedPrice;
  final double maxSelectedPrice;
  final List<String> releaseForms;
  final Set<int> selectedReleaseFormsId;
  final List<String> manufacturers;
  final Set<int> selectedManufacturersId;
  final List<String> countries;
  final Set<int> selectedCountriesId;

  final bool isWithoutPrescription;
  final bool isParticipatesInCampaign;
  final bool isDeliveryPossible;

  final bool isExpanded;
  final String query;
  final List<String> suggestions;

  const SearchScreenState({
    required this.minAllowedPrice,
    required this.maxAllowedPrice,
    required this.minSelectedPrice,
    required this.maxSelectedPrice,
    required this.releaseForms,
    required this.selectedReleaseFormsId,
    required this.manufacturers,
    required this.selectedManufacturersId,
    required this.countries,
    required this.selectedCountriesId,
    required this.isWithoutPrescription,
    required this.isParticipatesInCampaign,
    required this.isDeliveryPossible,
    this.isExpanded = false,
    required this.query,
    required this.suggestions,
  });

  SearchScreenState copyWith({
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
    bool? isExpanded,
    String? query,
    List<String>? suggestions,
  }) {
    return SearchScreenState(
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
      isExpanded: isExpanded ?? this.isExpanded,
      query: query ?? this.query,
      suggestions: suggestions ?? this.suggestions,
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
        isExpanded,
        query,
        suggestions,
      ];
}
