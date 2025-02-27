part of 'pharmacies_screen_bloc.dart';

class PharmaciesScreenState extends Equatable {
  final List<ProductPharmacyEntity>? pharmacies;
  final int? selectorIndex;
  final TypeReceiving? pharmacySortType;
  final String? query;

  const PharmaciesScreenState({
    this.pharmacies,
    this.selectorIndex,
    this.pharmacySortType,
    this.query,
  });

  PharmaciesScreenState copyWith({
    List<ProductPharmacyEntity>? pharmacies,
    int? selectorIndex,
    TypeReceiving? pharmacySortType,
    String? query,
  }) {
    return PharmaciesScreenState(
      pharmacies: pharmacies ?? this.pharmacies,
      selectorIndex: selectorIndex ?? this.selectorIndex,
      pharmacySortType: pharmacySortType ?? this.pharmacySortType,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props =>
      [pharmacies, selectorIndex, pharmacySortType, query];
}
