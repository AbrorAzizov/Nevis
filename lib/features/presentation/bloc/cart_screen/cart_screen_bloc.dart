import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/usecases/cart/get_cart.dart';

part 'cart_screen_event.dart';
part 'cart_screen_state.dart';

class CartScreenBloc extends Bloc<CartScreenEvent, CartScreenState> {
  ScrollController controller = ScrollController();

  TextEditingController fNameController = TextEditingController();
  TextEditingController sNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController cityController = TextEditingController();
  TextEditingController streetHomeController = TextEditingController();
  TextEditingController entranceController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController flatController = TextEditingController();
  TextEditingController doorPhoneController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  List<ProductEntity> inStockProducts = [];
  List<ProductEntity> pickUpAndInStockProducts = [];
  List<ProductEntity> noInStockProducts = [];

  final GetCartProducts getCartProducts;

  CartScreenBloc({required this.getCartProducts})
      : super(
          CartScreenState(
              products: [],
              isAllProductsChecked: false,
              selectedProductIds: {},
              pharmacies: [],
              filteredPharmacies: [],
              selectedPharmacy: null,
              promoCodes: [],
              cartType: TypeReceiving.delivery,
              paymentType: PaymentType.inPerson,
              isShowPharmaciesWorkingNow: false,
              isShowPharmaciesProductsInStock: false),
        ) {
    on<GetCartProductsEvent>(_getCartProducts);
    on<UpdateProductCountEvent>(_updateCounter);
    on<ChangeSelectorIndexEvent>(_onChangeSelector);
  }

  void _getCartProducts(
      GetCartProductsEvent event, Emitter<CartScreenState> emit) async {
    final failureOrLoads = await getCartProducts();
    failureOrLoads.fold(
        (_) => emit(state.copyWith(
            errorMessage: 'ошибка загрузки корзины', isLoading: false)),
        (products) =>
            emit(state.copyWith(products: products, isLoading: false)));
  }

  void _updateCounter(
      UpdateProductCountEvent event, Emitter<CartScreenState> emit) {
    final newCounters = Map<int, int>.from(state.counters);
    newCounters[event.productId] = event.count;
    emit(state.copyWith(counters: newCounters));
  }

  void _onChangeSelector(
      ChangeSelectorIndexEvent event, Emitter<CartScreenState> emit) {
    emit(state.copyWith(selectorIndex: event.typeReceiving));
  }
}
