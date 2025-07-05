part of 'favorite_pharmacies_bloc.dart';

abstract class FavoritePharmaciesEvent extends Equatable {
  const FavoritePharmaciesEvent();

  @override
  List<Object?> get props => [];
}

/// Загружаем все аптеки и избранные один раз при инициализации
class LoadInitialDataEvent extends FavoritePharmaciesEvent {}

/// Загружаем только избранные аптеки
class LoadFavoritePharmaciesEvent extends FavoritePharmaciesEvent {}

/// Показываем все аптеки (при нажатии "Найти аптеку на карте")
class ShowPharmaciesEvent extends FavoritePharmaciesEvent {}

/// Изменяем индекс выбора "Карта / Список"
class ChangeSelectorIndexEvent extends FavoritePharmaciesEvent {
  final int selectorIndex;

  const ChangeSelectorIndexEvent(this.selectorIndex);

  @override
  List<Object?> get props => [selectorIndex];
}

/// Обновляем запрос поиска
class ChangeQueryEvent extends FavoritePharmaciesEvent {
  final String query;

  const ChangeQueryEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// Нажата точка на карте
class PharmacyMarkerTappedEvent extends FavoritePharmaciesEvent {
  final dynamic pharmacy;

  const PharmacyMarkerTappedEvent(this.pharmacy);

  @override
  List<Object?> get props => [pharmacy];
}

/// Добавление аптеки в избранное
class AddToFavoritesPharmacyEvent extends FavoritePharmaciesEvent {
  final int id;

  const AddToFavoritesPharmacyEvent(this.id);

  @override
  List<Object?> get props => [id];
}

/// Удаление аптеки из избранного
class RemoveFromFavoritesPharmacyEvent extends FavoritePharmaciesEvent {
  final int id;

  const RemoveFromFavoritesPharmacyEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ResetSearchEvent extends FavoritePharmaciesEvent {}
