part of 'favorite_pharmacies_bloc.dart';

sealed class FavoritePharmaciesEvent extends Equatable {
  const FavoritePharmaciesEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends FavoritePharmaciesEvent {}

class ChangeSelectorIndexEvent extends FavoritePharmaciesEvent {
  final int selectorIndex;
  const ChangeSelectorIndexEvent(this.selectorIndex);
}

class PharmacyMarkerTappedEvent extends FavoritePharmaciesEvent {
  final PharmacyEntity pharmacy;
  const PharmacyMarkerTappedEvent({required this.pharmacy});
}

class ChangeQueryEvent extends FavoritePharmaciesEvent {
  final String query;
  const ChangeQueryEvent(this.query);
}
