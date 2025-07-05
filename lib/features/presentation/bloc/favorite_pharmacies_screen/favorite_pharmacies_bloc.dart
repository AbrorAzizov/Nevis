import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/core/models/map_marker_model.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/usecases/pharmacies/add_to_favorites_pharmacy.dart';
import 'package:nevis/features/domain/usecases/pharmacies/get_favorite_pharmacies.dart';
import 'package:nevis/features/domain/usecases/pharmacies/get_pharmacies.dart';
import 'package:nevis/features/domain/usecases/pharmacies/remove_from_favorites_pharmacy.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

part 'favorite_pharmacies_event.dart';
part 'favorite_pharmacies_state.dart';

class FavoritePharmaciesBloc
    extends Bloc<FavoritePharmaciesEvent, FavoritePharmaciesState> {
  final GetFavoritePharmaciesUC getFavoritePharmaciesUC;
  final GetPharmaciesUC getPharmaciesUC;
  final RemoveFromFavoritesPharmacyUC removeFromFavoritesPharmacyUC;
  final AddToFavoritesPharmacyUC addToFavoritesPharmacyUC;
  final List<PharmacyEntity> _allPharmacies = [];

  FavoritePharmaciesBloc({
    required this.removeFromFavoritesPharmacyUC,
    required this.getFavoritePharmaciesUC,
    required this.getPharmaciesUC,
    required this.addToFavoritesPharmacyUC,
  }) : super(const FavoritePharmaciesState(isLoading: false)) {
    on<ResetSearchEvent>(_onResetSearch);
    on<LoadInitialDataEvent>(_onLoadInitialData);
    on<LoadFavoritePharmaciesEvent>(_onLoadFavoritePharmacies);
    on<PharmacyMarkerTappedEvent>(_onSelectPharmacy);
    on<ChangeQueryEvent>(_onChangeQueryEvent);
    on<ChangeSelectorIndexEvent>(_onChangeSelectorIndexEvent);
    on<ShowPharmaciesEvent>(_onShowPharmacies);
    on<AddToFavoritesPharmacyEvent>(_onAddToFavoritesPharmacy);
    on<RemoveFromFavoritesPharmacyEvent>(_onRemoveFromFavoritesPharmacy);
  }

  Future<void> _onLoadInitialData(
    LoadInitialDataEvent event,
    Emitter<FavoritePharmaciesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await getPharmaciesUC();
    result.fold(
      (_) => emit(state.copyWith(isLoading: false)),
      (pharmacies) {
        _allPharmacies
          ..clear()
          ..addAll(pharmacies);

        emit(state.copyWith(
          pharmacies: pharmacies,
          pharmacyPoints: _buildMapPoints(pharmacies),
          isLoading: false,
        ));
        add(LoadFavoritePharmaciesEvent());
      },
    );
  }

  Future<void> _onLoadFavoritePharmacies(
    LoadFavoritePharmaciesEvent event,
    Emitter<FavoritePharmaciesState> emit,
  ) async {
    final result = await getFavoritePharmaciesUC();
    result.fold(
      (_) => emit(state.copyWith(
        favoritePharmacies: [],
        errorMessage: 'Something went wrong',
      )),
      (pharmacies) {
        emit(state.copyWith(
          favoritePharmacies: pharmacies,
          favoritePoints: _buildMapPoints(pharmacies),
        ));
      },
    );
  }

  void _onChangeQueryEvent(
    ChangeQueryEvent event,
    Emitter<FavoritePharmaciesState> emit,
  ) {
    final query = event.query.replaceAll(RegExp(r'[^0-9]'), '');

    if (query.isEmpty) {
      emit(state.copyWith(pharmacies: _allPharmacies));
    } else {
      final results = _allPharmacies
          .where((item) => item.alias.toString().contains(query))
          .toList();
      emit(state.copyWith(
        pharmacies: results,
        pharmacyPoints: _buildMapPoints(results),
        errorMessage: results.isEmpty ? 'Нет совпадений' : null,
      ));
    }
  }

  void _onChangeSelectorIndexEvent(
    ChangeSelectorIndexEvent event,
    Emitter<FavoritePharmaciesState> emit,
  ) {
    emit(state.copyWith(selectorIndex: event.selectorIndex));
  }

  void _onShowPharmacies(
    ShowPharmaciesEvent event,
    Emitter<FavoritePharmaciesState> emit,
  ) {
    emit(state.copyWith(findPharmaciesPressed: true));
  }

  void _onSelectPharmacy(
    PharmacyMarkerTappedEvent event,
    Emitter<FavoritePharmaciesState> emit,
  ) {
    emit(state.copyWith(selectedPharmacy: event.pharmacy));
  }

  Future<void> _onAddToFavoritesPharmacy(
    AddToFavoritesPharmacyEvent event,
    Emitter<FavoritePharmaciesState> emit,
  ) async {
    final result = await addToFavoritesPharmacyUC(event.id);
    result.fold(
      (_) => emit(state.copyWith(
        errorMessage: 'Something went wrong',
      )),
      (_) => add(LoadFavoritePharmaciesEvent()),
    );
  }

  Future<void> _onRemoveFromFavoritesPharmacy(
    RemoveFromFavoritesPharmacyEvent event,
    Emitter<FavoritePharmaciesState> emit,
  ) async {
    final result = await removeFromFavoritesPharmacyUC(event.id);
    result.fold(
        (_) => emit(state.copyWith(
              errorMessage: 'Something went wrong',
            )), (_) {
      add(LoadFavoritePharmaciesEvent());
    });
  }

  List<MapMarkerModel> _buildMapPoints(List<PharmacyEntity> pharmacies) {
    return pharmacies
        .map((pharmacy) {
          double? lat;
          double? lng;

          final coordString = pharmacy.coordinates;
          if (coordString != null && coordString.isNotEmpty) {
            if (coordString.contains('longitude') &&
                coordString.contains('latitude')) {
              final lonMatch =
                  RegExp(r'longitude:\s*([-]?[0-9.]+)').firstMatch(coordString);
              final latMatch =
                  RegExp(r'latitude:\s*([-]?[0-9.]+)').firstMatch(coordString);
              if (lonMatch != null && latMatch != null) {
                lng = double.tryParse(lonMatch.group(1)!);
                lat = double.tryParse(latMatch.group(1)!);
              }
            } else {
              final parts = coordString.split(RegExp(r',\s*'));
              if (parts.length == 2) {
                lat = double.tryParse(parts[0]);
                lng = double.tryParse(parts[1]);
              }
            }
          }

          lat ??= pharmacy.gpsN;
          lng ??= pharmacy.gpsS;

          if (lat == null || lng == null || lat.isNaN || lng.isNaN) return null;
          if (lat < -90 || lat > 90 || lng < -180 || lng > 180) return null;

          return MapMarkerModel(
            id: pharmacy.pharmacyId!,
            point: Point(latitude: lat, longitude: lng),
            data: (pharmacy as PharmacyModel).toJson(),
          );
        })
        .whereType<MapMarkerModel>()
        .toList();
  }

  void _onResetSearch(
    ResetSearchEvent event,
    Emitter<FavoritePharmaciesState> emit,
  ) {
    emit(state.copyWith(findPharmaciesPressed: false));
  }
}
