part of 'pharmacies_screen_bloc.dart';

abstract class PharmaciesScreenEvent extends Equatable {
  const PharmaciesScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends PharmaciesScreenEvent {
  final List<ProductPharmacyEntity> pharmacies;

  const LoadDataEvent(this.pharmacies);
}

class ChangeSelectorIndexEvent extends PharmaciesScreenEvent {
  final int selectorIndex;
  const ChangeSelectorIndexEvent(this.selectorIndex);
}

class ChangeQueryEvent extends PharmaciesScreenEvent {
  final String query;
  const ChangeQueryEvent(this.query);
}

class ChangePharmacySortTypeEvent extends PharmaciesScreenEvent {
  final TypeReceiving pharmacySortType;

  const ChangePharmacySortTypeEvent(this.pharmacySortType);

  @override
  List<Object> get props => [pharmacySortType];
}
