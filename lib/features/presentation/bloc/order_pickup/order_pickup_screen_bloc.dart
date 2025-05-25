import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/core/models/map_marker_model.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/usecases/order/get_pharmacies_by_cart.dart';
import 'package:nevis/features/domain/usecases/pharmacies/get_favorite_pharmacies.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/locator_service.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

part 'order_pickup_screen_event.dart';
part 'order_pickup_screen_state.dart';

class OrderPickupScreenBloc
    extends Bloc<OrderPickupScreenEvent, OrderPickupScreenState> {
  final GetFavoritePharmaciesUC getFavoritePharmaciesUC;
  final GetPharmaciesByCartUC getPharmaciesByCartUC;
  List<PharmacyEntity> _allPharmacies = [];

  OrderPickupScreenBloc({
    required this.getFavoritePharmaciesUC,
    required this.getPharmaciesByCartUC,
  }) : super(const OrderPickupScreenState(isLoading: false)) {
    on<LoadPickupPharmaciesEvent>(_onLoadData);
    on<PickupPharmacySelectedEvent>(_onSelectPharmacy);
    on<PickupChangeQueryEvent>(_onChangeQueryEvent);
    on<PickupChangeSelectorIndexEvent>(_onChangeSelectorIndexEvent);
  }

  Future<void> _onLoadData(LoadPickupPharmaciesEvent event,
      Emitter<OrderPickupScreenState> emit) async {
    emit(state.copyWith(isLoading: true));
    final products = sl<CartScreenBloc>().state.cartProducts;
    final List<CartParams> cartParams = products
        .map((e) => CartParams(
            quantity: sl<CartScreenBloc>().state.counters[e.productId] ?? 1,
            id: e.productId!))
        .toList();
    final failureOrLoads = await getPharmaciesByCartUC(cartParams);
    List<MapMarkerModel> points = [];

    failureOrLoads.fold(
      (_) => emit(
          state.copyWith(errorMessage: 'Ошибка загрузки', isLoading: false)),
      (pharmacies) {
        _allPharmacies = pharmacies;
        points = pharmacies.map((pharmacy) {
          final coordinates =
              pharmacy.coordinates!.split(',').map((e) => e.trim()).toList();
          return MapMarkerModel(
            id: pharmacy.pharmacyId!,
            point: Point(
              latitude: double.tryParse(coordinates[0]) ?? 0,
              longitude: double.tryParse(coordinates[1]) ?? 0,
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
      PickupPharmacySelectedEvent event, Emitter<OrderPickupScreenState> emit) {
    emit(state.copyWith(selectedPharmacy: event.pharmacy));
  }

  void _onChangeQueryEvent(
      PickupChangeQueryEvent event, Emitter<OrderPickupScreenState> emit) {
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

  void _onChangeSelectorIndexEvent(PickupChangeSelectorIndexEvent event,
      Emitter<OrderPickupScreenState> emit) {
    emit(state.copyWith(selectorIndex: event.selectorIndex));
  }
}
