part of 'favorite_pharmacies_bloc.dart';

class FavoritePharmaciesState extends Equatable {
  final int selectorIndex;
  final List<PharmacyEntity> pharmacies;
  final List<MapMarkerModel> points;
  final PharmacyEntity? selectedPharmacy;
  final String? errorMessage;
  final bool isLoading;

  const FavoritePharmaciesState({
    this.selectorIndex = 0,
    this.pharmacies = const [],
    this.points = const [],
    this.selectedPharmacy,
    this.errorMessage,
    this.isLoading = false,
  });

  FavoritePharmaciesState copyWith({
    int? selectorIndex,
    List<PharmacyEntity>? pharmacies,
    List<MapMarkerModel>? points,
    PharmacyEntity? selectedPharmacy,
    String? errorMessage,
    bool? isLoading,
  }) {
    return FavoritePharmaciesState(
      selectorIndex: selectorIndex ?? this.selectorIndex,
      pharmacies: pharmacies ?? this.pharmacies,
      points: points ?? this.points,
      selectedPharmacy: selectedPharmacy ?? this.selectedPharmacy,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        selectorIndex,
        pharmacies,
        points,
        selectedPharmacy,
        errorMessage,
        isLoading
      ];
}
