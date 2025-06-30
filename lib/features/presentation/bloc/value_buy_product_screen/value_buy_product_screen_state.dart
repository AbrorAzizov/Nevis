part of 'value_buy_product_screen_bloc.dart';

class ValueBuyProductScreenState extends Equatable {
  final bool isLoading;
  final String? error;
  final int selectorIndex;
  final List<MapMarkerModel> points;
  final List<ProductPharmacyEntity>? pharmacies;
  final ProductPharmacyEntity? selectedPharmacyMarker;
  final ProductPharmacyEntity? selectedPharmacyCard;
  final Map<int, int> counters;
  final BookBargainProductResponse? bookResponse;
  final BargainProductEntity? bargainProduct;

  const ValueBuyProductScreenState({
    this.counters = const {},
    this.selectedPharmacyMarker,
    this.selectedPharmacyCard,
    this.selectorIndex = 0,
    this.isLoading = true,
    this.error,
    this.points = const [],
    this.pharmacies = const [],
    this.bookResponse,
    this.bargainProduct,
  });

  ValueBuyProductScreenState copyWith({
    int? selectorIndex,
    List<ProductPharmacyEntity>? pharmacies,
    List<MapMarkerModel>? points,
    ProductPharmacyEntity? selectedPharmacyMarker,
    String? error,
    bool? isLoading,
    ProductPharmacyEntity? selectedPharmacyCard,
    Map<int, int>? counters,
    BookBargainProductResponse? bookResponse,
    BargainProductEntity? bargainProduct,
  }) {
    return ValueBuyProductScreenState(
      selectorIndex: selectorIndex ?? this.selectorIndex,
      pharmacies: pharmacies ?? this.pharmacies,
      points: points ?? this.points,
      selectedPharmacyMarker:
          selectedPharmacyMarker ?? this.selectedPharmacyMarker,
      error: error,
      isLoading: isLoading ?? this.isLoading,
      counters: counters ?? this.counters,
      selectedPharmacyCard: selectedPharmacyCard ?? this.selectedPharmacyCard,
      bookResponse: bookResponse ?? this.bookResponse,
      bargainProduct: bargainProduct ?? this.bargainProduct,
    );
  }

  @override
  List<Object?> get props => [
        selectorIndex,
        pharmacies,
        points,
        selectedPharmacyMarker,
        error,
        isLoading,
        selectedPharmacyCard,
        counters,
        bookResponse,
        bargainProduct,
      ];
}
