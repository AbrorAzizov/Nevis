import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/usecases/cart/add_product_to_cart.dart';
import 'package:nevis/features/domain/usecases/cart/delete_product_from_cart.dart';
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
  final AddProductToCartUC addProductToCart;
  final DeleteProductFromCartUC deleteProductFromCart;

  CartScreenBloc(
      {required this.getCartProducts,
      required this.deleteProductFromCart,
      required this.addProductToCart})
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
    on<GetProductsEvent>(_getProducts);
    on<ClearCartEvent>(_clearCart);
    on<AddProductToCart>(_addProductTocart);
    on<DeleteProductFromCart>(_deleteProductFromCart);
  }
  void _getCartProducts(
      GetCartProductsEvent event, Emitter<CartScreenState> emit) async {
    final failureOrLoads = await getCartProducts();

    failureOrLoads.fold(
      (_) => emit(state.copyWith(
        errorMessage: 'ошибка загрузки корзины',
        isLoading: false,
      )),
      (cart) {
        final newCounters = <int, int>{};

        for (var item in cart.cartItems) {
          if (item.productId != null && item.count != null) {
            newCounters[item.productId!] = item.count!;
          }
        }

        emit(state.copyWith(
          totalDiscounts: cart.totalDiscounts,
          totalBonuses: cart.totalBonuses,
          totalPrice: cart.totalPrice,
          cartProducts: cart.cartItems,
          counters:
              cart.cartItems.isEmpty ? {} : newCounters, // <-- ключевая строка
          isLoading: false,
        ));
      },
    );
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
      UpdateProductCountEvent event, Emitter<CartScreenState> emit) async {
    final failureOrSuccess = await addProductToCart(
      CartParams(quantity: event.count, id: event.productId),
    );

    failureOrSuccess.fold(
      (failure) {
        if (failure is MaxQuantityExceededFailure) {
          Get.showSnackbar(GetSnackBar(
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 2),
            title: 'Ошибка при добавлении товара',
            message: failure.message,
          ));
        }
      },
      (_) {
        final newCounters = Map<int, int>.from(state.counters);
        newCounters[event.productId] = event.count;
        emit(state.copyWith(counters: newCounters));
        add(GetCartProductsEvent());
      },
    );
  }

  void _onChangeSelector(
      ChangeSelectorIndexEvent event, Emitter<CartScreenState> emit) {
    emit(state.copyWith(cartType: event.typeReceiving));
  }

  void _clearCart(ClearCartEvent event, Emitter<CartScreenState> emit) {
    emit(state.copyWith(cartProducts: [], counters: {}));
  }

  void _addProductTocart(
      AddProductToCart event, Emitter<CartScreenState> emit) async {
    if (event.product.productId != null) {
      final productId = event.product.productId!;
      final currentCount = state.counters[productId] ?? 0;
      final newCount = currentCount + 1;

      final failureOrLoads = await addProductToCart(
        CartParams(quantity: newCount, id: productId),
      );
      failureOrLoads.fold(
        (_) => emit(
            state.copyWith(errorMessage: 'ошибка добавления товара в корзину')),
        (_) => add(GetCartProductsEvent()),
      );
    }
  }

  void _deleteProductFromCart(
      DeleteProductFromCart event, Emitter<CartScreenState> emit) async {
    final failureOrLoads = await deleteProductFromCart(event.productId);

    failureOrLoads.fold(
        (_) => emit(
            state.copyWith(errorMessage: 'ошибка удаление товара из корзины')),
        (_) {
      final counters = state.counters;
      counters.remove(event.productId);

      emit(state.copyWith(counters: counters));
      add(GetCartProductsEvent());
    });
  }
}
