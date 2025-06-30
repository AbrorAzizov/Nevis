import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/core/models/map_marker_model.dart';
import 'package:nevis/core/params/bargain_product_params.dart';
import 'package:nevis/core/params/book_bargain_product_params.dart';
import 'package:nevis/features/data/models/book_bargain_product_response.dart';
import 'package:nevis/features/data/models/product_pharmacy_model.dart';
import 'package:nevis/features/domain/entities/bargain_product_entity.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/domain/usecases/products/book_bargain_product.dart';
import 'package:nevis/features/domain/usecases/products/get_bargain_product.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

part 'value_buy_product_screen_event.dart';
part 'value_buy_product_screen_state.dart';

class ValueBuyProductScreenBloc
    extends Bloc<ValueBuyProductScreenEvent, ValueBuyProductScreenState> {
  final GetBargainProductUC getBargainProductUC;
  final BookBargainProductUC bookBargainProductUC;

  ValueBuyProductScreenBloc({
    required this.getBargainProductUC,
    required this.bookBargainProductUC,
  }) : super(const ValueBuyProductScreenState(isLoading: false)) {
    on<LoadDataEvent>(_onLoadData);
    on<PharmacyMarkerTappedEvent>(_onSelectPharmacyMarker);
    on<ChangeQueryEvent>(_onChangeQueryEvent);
    on<ChangeSelectorIndexEvent>(_onChangeSelectorIndexEvent);
    on<PharmacyCardTappedEvent>(_onSelectPharmacyCard);
    on<UpdateCounterEvent>(_onUpdateCounterEvent);
    on<BookBargainProductEvent>(_onBookBargainProduct);
  }

  List<MapMarkerModel> _buildPoints(List<ProductPharmacyEntity> pharmacies) {
    return List.generate(
      pharmacies.length,
      (index) {
        final pharmacy = pharmacies[index];
        final coordinates = pharmacy.coordinates;
        final latString = coordinates?.split(', ')[0];
        final lonString = coordinates?.split(', ')[1];
        return MapMarkerModel(
          id: pharmacy.pharmacyId!,
          point: Point(
            latitude: double.tryParse(latString ?? '') ?? 0,
            longitude: double.tryParse(lonString ?? '') ?? 0,
          ),
          data: (pharmacy as ProductPharmacyModel).toJson(),
        );
      },
    );
  }

  Future<void> _onLoadData(
      LoadDataEvent event, Emitter<ValueBuyProductScreenState> emit) async {
    emit(state.copyWith(isLoading: true));

    final params = BargainProductParams(
        regionId: 2, productId: event.productId.toString());

    final failureOrLoads = await getBargainProductUC(params);
    failureOrLoads.fold(
      (failure) =>
          emit(state.copyWith(error: 'Ошибка загрузки', isLoading: false)),
      (response) {
        emit(
          state.copyWith(
            pharmacies: response.pharmacies,
            isLoading: false,
            points: _buildPoints(response.pharmacies),
            bargainProduct: response,
          ),
        );
      },
    );
  }

  Future<void> _onBookBargainProduct(BookBargainProductEvent event,
      Emitter<ValueBuyProductScreenState> emit) async {
    emit(state.copyWith(isLoading: true));
    final params = BookBargainProductParams(
      productId: event.productId,
      pharmacyId: event.pharmacyId,
      quantity: event.quantity,
    );
    final result = await bookBargainProductUC(params);
    result.fold(
      (failure) =>
          emit(state.copyWith(error: 'Ошибка бронирования', isLoading: false)),
      (response) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  void _onSelectPharmacyMarker(PharmacyMarkerTappedEvent event,
      Emitter<ValueBuyProductScreenState> emit) {
    emit(state.copyWith(selectedPharmacyMarker: event.pharmacy));
  }

  void _onSelectPharmacyCard(
      PharmacyCardTappedEvent event, Emitter<ValueBuyProductScreenState> emit) {
    if (event.pharmacy != state.selectedPharmacyCard) {
      emit(state.copyWith(selectedPharmacyCard: event.pharmacy));
    } else {
      emit(state.copyWith(selectedPharmacyCard: null));
    }
  }

  void _onChangeQueryEvent(
      ChangeQueryEvent event, Emitter<ValueBuyProductScreenState> emit) {
    final query = event.query.trim().toLowerCase();
    List<ProductPharmacyEntity> filtered;
    if (query.isEmpty) {
      filtered = state.bargainProduct?.pharmacies ?? [];
    } else {
      filtered = (state.bargainProduct?.pharmacies ?? [])
          .where((item) => (item.address ?? '').toLowerCase().contains(query))
          .toList();
    }
    emit(state.copyWith(
      pharmacies: filtered,
      points: _buildPoints(filtered),
      error: filtered.isEmpty ? 'Нет совпадений' : null,
    ));
  }

  void _onChangeSelectorIndexEvent(ChangeSelectorIndexEvent event,
      Emitter<ValueBuyProductScreenState> emit) {
    emit(state.copyWith(selectorIndex: event.selectorIndex));
  }

  void _onUpdateCounterEvent(
      UpdateCounterEvent event, Emitter<ValueBuyProductScreenState> emit) {
    final newCounters = Map<int, int>.from(state.counters);
    newCounters[event.pharmacyId] = event.counter;
    emit(state.copyWith(counters: newCounters));
  }
}
