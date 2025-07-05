part of 'favorite_pharmacies_bloc.dart';

class FavoritePharmaciesState extends Equatable {
  final int selectorIndex;
  final List<PharmacyEntity> pharmacies;
  final List<PharmacyEntity> favoritePharmacies;
  final List<MapMarkerModel> favoritePoints;
  final List<MapMarkerModel> pharmacyPoints;
  final PharmacyEntity? selectedPharmacy;
  final String? errorMessage;
  final bool isLoading;
  final bool findPharmaciesPressed;

  const FavoritePharmaciesState({
    this.isLoading = false,
    this.favoritePharmacies = const [],
    this.pharmacies = const [],
    this.selectorIndex = 0,
    this.selectedPharmacy,
    this.errorMessage,
    this.findPharmaciesPressed = false,
    this.favoritePoints = const [],
    this.pharmacyPoints = const [],
  });

  FavoritePharmaciesState copyWith({
    int? selectorIndex,
    List<PharmacyEntity>? pharmacies,
    List<PharmacyEntity>? favoritePharmacies,
    List<MapMarkerModel>? points,
    PharmacyEntity? selectedPharmacy,
    String? errorMessage,
    bool? isLoading,
    List<MapMarkerModel>? favoritePoints,
    List<MapMarkerModel>? pharmacyPoints,
    bool? findPharmaciesPressed,
  }) {
    return FavoritePharmaciesState(
        selectorIndex: selectorIndex ?? this.selectorIndex,
        pharmacies: pharmacies ?? this.pharmacies,
        favoritePoints: favoritePoints ?? this.favoritePoints,
        pharmacyPoints: pharmacyPoints ?? this.pharmacyPoints,
        selectedPharmacy: selectedPharmacy ?? this.selectedPharmacy,
        errorMessage: errorMessage,
        isLoading: isLoading ?? this.isLoading,
        favoritePharmacies: favoritePharmacies ?? this.favoritePharmacies,
        findPharmaciesPressed:
            findPharmaciesPressed ?? this.findPharmaciesPressed);
  }

  @override
  List<Object?> get props => [
        selectorIndex,
        pharmacies,
        pharmacyPoints,
        favoritePoints,
        selectedPharmacy,
        errorMessage,
        isLoading,
        favoritePharmacies,
        findPharmaciesPressed
      ];
}
