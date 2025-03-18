part of 'favourite_pharmacies_bloc_bloc.dart';

sealed class FavouritePharmaciesEvent extends Equatable {
  const FavouritePharmaciesEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends  FavouritePharmaciesEvent{

}

class ChangeSelectorIndexEvent extends FavouritePharmaciesEvent {
  final int selectorIndex;
  const ChangeSelectorIndexEvent(this.selectorIndex);
}

class PharmacyMarkerTappedEvent extends FavouritePharmaciesEvent {
  final PharmacyEntity pharmacy;
  const PharmacyMarkerTappedEvent({required this.pharmacy});
}