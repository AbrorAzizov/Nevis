part of 'value_buy_product_screen_bloc.dart';

class ValueBuyProductScreenState extends Equatable {
  final bool isLoading;
  final String? error;
  final int selectorIndex;
  final ProductEntity? product;
  final List<MapMarkerModel> points;
  final List<ProductPharmacyEntity>? pharmacies;
  final ProductPharmacyEntity? selectedPharmacy;

  const ValueBuyProductScreenState({
    this.selectedPharmacy,
    this.selectorIndex = 0,
    this.isLoading = true,
    this.error,
    this.points = const [],
    this.product,
    this.pharmacies = const [],
  });

  ValueBuyProductScreenState copyWith({
    int? selectorIndex,
    List<ProductPharmacyEntity>? pharmacies,
    List<MapMarkerModel>? points,
    ProductPharmacyEntity? selectedPharmacy,
    String? error,
    bool? isLoading,
  }) {
    return ValueBuyProductScreenState(
      selectorIndex: selectorIndex ?? this.selectorIndex,
      pharmacies: pharmacies ?? this.pharmacies,
      points: points ?? this.points,
      selectedPharmacy: selectedPharmacy ?? this.selectedPharmacy,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [selectorIndex, pharmacies, points, selectedPharmacy, error, isLoading];
}
