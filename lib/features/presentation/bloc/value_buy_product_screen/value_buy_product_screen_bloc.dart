import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/core/models/map_marker_model.dart';
import 'package:nevis/features/data/models/product_pharmacy_model.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/domain/usecases/products/get_product_pharmacies.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

part 'value_buy_product_screen_event.dart';
part 'value_buy_product_screen_state.dart';

class ValueBuyProductScreenBloc
    extends Bloc<ValueBuyProductScreenEvent, ValueBuyProductScreenState> {
  final GetProductPharmaciesUC getProductPharmaciesUC;
  List<ProductPharmacyEntity> _allPharmacies = [];

  ValueBuyProductScreenBloc({
    required this.getProductPharmaciesUC,
  }) : super(const ValueBuyProductScreenState(isLoading: false)) {
    on<LoadDataEvent>(_onLoadData);
    on<PharmacyMarkerTappedEvent>(_onSelectPharmacy);
    on<ChangeQueryEvent>(_onChangeQueryEvent);
    on<ChangeSelectorIndexEvent>(_onChangeSelectorIndexEvent);
  }

  Future<void> _onLoadData(
      LoadDataEvent event, Emitter<ValueBuyProductScreenState> emit) async {
    emit(state.copyWith(isLoading: true));

    final failureOrLoads = await getProductPharmaciesUC(event.productId);
    List<MapMarkerModel> points = [];
    failureOrLoads.fold(
      (_) =>
          emit(state.copyWith(error: 'Something went wrong', isLoading: false)),
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
            data: (pharmacy as ProductPharmacyModel).toJson(),
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

  void _onSelectPharmacy(PharmacyMarkerTappedEvent event,
      Emitter<ValueBuyProductScreenState> emit) {
    emit(state.copyWith(selectedPharmacy: event.pharmacy));
  }

  void _onChangeQueryEvent(
      ChangeQueryEvent event, Emitter<ValueBuyProductScreenState> emit) {
    final query = event.query.replaceAll(RegExp(r'[^0-9]'), '');

    if (query.isEmpty) {
      emit(state.copyWith(pharmacies: _allPharmacies));
    } else {
      final results = _allPharmacies
          .where((item) => item.pharmacyAlias.toString().contains(query))
          .toList();
      emit(state.copyWith(
        pharmacies: results,
        error: results.isEmpty ? 'Нет совпадений' : null,
      ));
    }
  }

  void _onChangeSelectorIndexEvent(ChangeSelectorIndexEvent event,
      Emitter<ValueBuyProductScreenState> emit) {
    emit(state.copyWith(selectorIndex: event.selectorIndex));
  }
}
