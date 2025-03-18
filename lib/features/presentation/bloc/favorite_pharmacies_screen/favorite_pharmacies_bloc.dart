import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/core/models/map_marker_model.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/usecases/content/get_pharmacies.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

part 'favorite_pharmacies_event.dart';
part 'favorite_pharmacies_state.dart';

class FavoritePharmaciesBloc
    extends Bloc<FavoritePharmaciesEvent, FavoritePharmaciesState> {
  final GetPharmaciesUC getPharmaciesUC;
  List<PharmacyEntity> _allPharmacies = [];

  FavoritePharmaciesBloc({required this.getPharmaciesUC})
      : super(const FavoritePharmaciesState(isLoading: false)) {
    on<LoadDataEvent>(_onLoadData);
    on<PharmacyMarkerTappedEvent>(_onSelectPharmacy);
    on<ChangeQueryEvent>(_onChangeQueryEvent);
    on<ChangeSelectorIndexEvent>(_onChangeSelectorIndexEvent);
  }

  Future<void> _onLoadData(
      LoadDataEvent event, Emitter<FavoritePharmaciesState> emit) async {
    emit(state.copyWith(isLoading: true));

    final failureOrLoads = await getPharmaciesUC('');
    List<MapMarkerModel> points = [];

    failureOrLoads.fold(
      (_) => emit(state.copyWith(
          errorMessage: 'Something went wrong', isLoading: false)),
      (pharmacies) {
        _allPharmacies = pharmacies;

        points = pharmacies.map((pharmacy) {
          final coordinates = pharmacy.coordinates!.split(', ');
          return MapMarkerModel(
            id: pharmacy.pharmacyId!,
            point: Point(
              latitude: double.parse(coordinates.first),
              longitude: double.parse(coordinates.last),
            ),
            data: (pharmacy as PharmacyModel).toJson(),
          );
        }).toList();

        emit(state.copyWith(
          pharmacies: pharmacies,
          points: points,
          isLoading: false,
        ));
      },
    );
  }

  void _onSelectPharmacy(
      PharmacyMarkerTappedEvent event, Emitter<FavoritePharmaciesState> emit) {
    emit(state.copyWith(selectedPharmacy: event.pharmacy));
  }

  void _onChangeQueryEvent(
      ChangeQueryEvent event, Emitter<FavoritePharmaciesState> emit) {
    final query = event.query.replaceAll(RegExp(r'[^0-9]'), '');

    if (query.isEmpty) {
      emit(state.copyWith(pharmacies: _allPharmacies));
    } else {
      final results = _allPharmacies
          .where((item) => item.alias.toString().contains(query))
          .toList();
      emit(state.copyWith(
        pharmacies: results,
        errorMessage: results.isEmpty ? 'Нет совпадений' : null,
      ));
    }
  }

  void _onChangeSelectorIndexEvent(
      ChangeSelectorIndexEvent event, Emitter<FavoritePharmaciesState> emit) {
    emit(state.copyWith(selectorIndex: event.selectorIndex));
  }
}
