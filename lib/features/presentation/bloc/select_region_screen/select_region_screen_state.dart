part of 'select_region_screen_bloc.dart';

class SelectRegionScreenState extends Equatable {
  final bool isButtonActive;
  final bool showError;
  final List<String> popularCities;
  final String? selectedRegion;

  const SelectRegionScreenState({
    this.isButtonActive = false,
    this.showError = false,
    this.selectedRegion,
    required this.popularCities,
  });

  SelectRegionScreenState copyWith({
    bool? isButtonActive,
    bool? showError,
    List<String>? popularCities,
    String? selectedRegion,
  }) {
    return SelectRegionScreenState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
      showError: showError ?? this.showError,
      popularCities: popularCities ?? this.popularCities,
      selectedRegion: selectedRegion ?? this.selectedRegion,
    );
  }

  @override
  List<Object?> get props =>
      [isButtonActive, showError, selectedRegion, popularCities];
}
