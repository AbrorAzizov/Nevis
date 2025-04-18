import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/data/models/product_model.dart';
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

  final GetCartProductsUC getCartProducts;

  CartScreenBloc({required this.getCartProducts})
      : super(
          CartScreenState(
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
    on<RemoveProductEvent>(_onRemoveItem);
    on<GetProductsEvent>(_getProducts);
    on<ClearCartEvent>(_clearCart);
  }

  void _getCartProducts(
      GetCartProductsEvent event, Emitter<CartScreenState> emit) async {
    final failureOrLoads = await getCartProducts();
    failureOrLoads.fold(
        (_) => emit(state.copyWith(
            errorMessage: 'ошибка загрузки корзины', isLoading: false)),
        (cartProducts) =>
            emit(state.copyWith(cartProducts: cartProducts, isLoading: false)));
  }

  void _getProducts(
      GetProductsEvent event, Emitter<CartScreenState> emit) async {
    try {
      String jsonString = await rootBundle.loadString('assets/products.json');
      final data = jsonDecode(jsonString);
      List<dynamic> dataList = data['data'];
      List<ProductEntity> products =
          dataList.map((e) => ProductModel.fromJson(e)).toList();
      emit(state.copyWith(products: products, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
      ));
    }
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

  void _onRemoveItem(RemoveProductEvent event, Emitter<CartScreenState> emit) {
    final updatedProducts = List<ProductEntity>.from(state.cartProducts)
      ..remove(event.product);

    final updatedCounters = Map<int, int>.from(state.counters)
      ..remove(event.product.productId);

    emit(state.copyWith(
      cartProducts: updatedProducts,
      counters: updatedCounters,
    ));
  }

  void _clearCart(ClearCartEvent event, Emitter<CartScreenState> emit) {
    emit(state.copyWith(cartProducts: [], counters: {}));
  }
}
