part of 'favourite_pharmacies_bloc_bloc.dart';
abstract class FavouritePharmaciesState {
  final int selectorIndex;

  const FavouritePharmaciesState({this.selectorIndex = 0});
}

class FavouritePharmaciesInitial extends FavouritePharmaciesState {
  
}

class FavouritePharmaciesLoading extends FavouritePharmaciesState {}

class FavouritePharmaciesLoaded extends FavouritePharmaciesState {
  final List<MapObject> mapObjects;
  final PharmacyEntity? selectedPharmacy;

  FavouritePharmaciesLoaded({
    required this.mapObjects,
    this.selectedPharmacy,
  });

  FavouritePharmaciesLoaded copyWith({
    List<MapObject>? mapObjects,
    PharmacyEntity? selectedPharmacy,
  }) {
    return FavouritePharmaciesLoaded(
      mapObjects: mapObjects ?? this.mapObjects,
      selectedPharmacy: selectedPharmacy,
    );
  }
}

class FavouritePharmaciesError extends FavouritePharmaciesState {
  final String message;

  FavouritePharmaciesError({required this.message});
}