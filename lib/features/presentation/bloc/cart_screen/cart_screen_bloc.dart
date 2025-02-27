import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

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
  Pharmacy? selectedPharmacy;

  CartScreenBloc()
      : super(
          CartScreenState(
              products: [],
              isAllProductsChecked: false,
              selectedProductIds: {},
              pharmacies: [
                Pharmacy(
                  id: 0,
                  isWorkingNow: false,
                  availableProducts: List.generate(
                    7,
                    (index) => AvailableProducts(
                      id: index,
                      count: 3,
                      expiredDate: DateTime.now(),
                    ),
                  ),
                ),
                Pharmacy(
                  id: 1,
                  availableProducts: [3, 4, 5]
                      .map(
                        (e) => AvailableProducts(
                          id: e,
                          count: 3,
                          expiredDate: DateTime.now(),
                        ),
                      )
                      .toList(),
                ),
                Pharmacy(
                  id: 2,
                  isWorkingNow: false,
                  availableProducts: List.generate(
                    7,
                    (index) => AvailableProducts(
                      id: index,
                      count: 3,
                      expiredDate: DateTime.now(),
                    ),
                  ),
                ),
                Pharmacy(
                  id: 3,
                  availableProducts: [3, 4, 5]
                      .map(
                        (e) => AvailableProducts(
                          id: e,
                          count: 3,
                          expiredDate: DateTime.now(),
                        ),
                      )
                      .toList(),
                ),
                Pharmacy(
                  id: 4,
                  availableProducts: List.generate(
                    7,
                    (index) => AvailableProducts(
                      id: index,
                      count: 3,
                      expiredDate: DateTime.now(),
                    ),
                  ),
                ),
              ],
              filteredPharmacies: [
                Pharmacy(
                  id: 0,
                  isWorkingNow: false,
                  availableProducts: List.generate(
                    7,
                    (index) => AvailableProducts(
                      id: index,
                      count: 3,
                      expiredDate: DateTime.now(),
                    ),
                  ),
                ),
                Pharmacy(
                  id: 1,
                  availableProducts: [3, 4, 5]
                      .map(
                        (e) => AvailableProducts(
                          id: e,
                          count: 3,
                          expiredDate: DateTime.now(),
                        ),
                      )
                      .toList(),
                ),
                Pharmacy(
                  id: 2,
                  isWorkingNow: false,
                  availableProducts: List.generate(
                    7,
                    (index) => AvailableProducts(
                      id: index,
                      count: 3,
                      expiredDate: DateTime.now(),
                    ),
                  ),
                ),
                Pharmacy(
                  id: 3,
                  availableProducts: [3, 4, 5]
                      .map(
                        (e) => AvailableProducts(
                          id: e,
                          count: 3,
                          expiredDate: DateTime.now(),
                        ),
                      )
                      .toList(),
                ),
                Pharmacy(
                  id: 4,
                  availableProducts: List.generate(
                    7,
                    (index) => AvailableProducts(
                      id: index,
                      count: 3,
                      expiredDate: DateTime.now(),
                    ),
                  ),
                ),
              ],
              selectedPharmacy: null,
              promoCodes: [],
              cartType: TypeReceiving.delivery,
              paymentType: PaymentType.courier,
              isShowPharmaciesWorkingNow: false,
              isShowPharmaciesProductsInStock: false),
        ) {
    on<ToggleSelectionEvent>(_onToggleSelection);
    on<ChangeProductCountEvent>(_onChangeProductCount);
    on<ToggleShowPharmaciesWorkingNowEvent>(_onToggleShowPharmaciesWorkingNow);
    on<ToggleShowPharmaciesProductsInStockEvent>(
        _onToggleShowPharmaciesProductsInStock);

    on<PickAllProductsEvent>(
      (event, emit) async {
        Set<int> selectedProductIds = {};

        //if (!state.isAllProductsChecked) {
        //  selectedProductIds.addAll(state.products
        //      .where((e) => e.inStock)
        //      .map((e) => e.productId)
        //      .toList());
        //}

        await update();
        emit(
          state.copyWith(
              selectedProductIds: selectedProductIds,
              isAllProductsChecked: selectedProductIds.isNotEmpty),
        );
      },
    );

    on<ClearProductsEvent>(
      (event, emit) async {
        await update();
        emit(
          state.copyWith(
              products: [],
              selectedProductIds: {},
              isAllProductsChecked: false,
              promoCodes: []),
        );
      },
    );

    on<DeleteProductEvent>(
      (event, emit) async {
        List<ProductEntity> updatedProducts = List.from(state.products);
        Set<int> selectedProductIds = Set<int>.from(state.selectedProductIds);
        updatedProducts.removeWhere((e) => e.productId == event.productId);
        selectedProductIds.remove(event.productId);

        await update();
        emit(
          state.copyWith(
              products: updatedProducts,
              selectedProductIds: selectedProductIds),
        );
      },
    );

    on<AddPromoCodeEvent>(
      (event, emit) async {
        List<int> promoCodes = List<int>.from(state.promoCodes);
        promoCodes.add(promoCodes.length);

        await update();
        emit(
          state.copyWith(promoCodes: promoCodes),
        );
      },
    );

    on<DeletePromoCodeEvent>(
      (event, emit) async {
        List<int> promoCodes = List<int>.from(state.promoCodes);
        promoCodes.remove(promoCodes.length - 1);

        await update();
        emit(
          state.copyWith(promoCodes: promoCodes),
        );
      },
    );

    on<ChangeCartTypeEvent>((event, emit) async {
      await update();
      emit(state.copyWith(cartType: event.cartType));
    });

    on<ChangePaymentTypeEvent>((event, emit) async {
      await update();
      emit(state.copyWith(paymentType: event.paymentType));
    });

    on<SelectPharmacy>((event, emit) async {
      emit(state.copyWith(selectedPharmacy: event.pharmacyId));
      await update();
    });

    on<ScrollUpListEvent>((_, __) {
      controller.animateTo(0,
          duration: Duration(milliseconds: 700), curve: Curves.easeOut);
    });
  }

  void _onToggleShowPharmaciesWorkingNow(
      ToggleShowPharmaciesWorkingNowEvent event,
      Emitter<CartScreenState> emit) {
    // Начинаем с текущего списка отфильтрованных аптек
    List<Pharmacy> filteredPharmacies = List.from(state.filteredPharmacies);

    if (event.isShowPharmaciesWorkingNow ?? false) {
      // Применяем фильтр только к аптекарским учреждениям, работающим в данный момент
      filteredPharmacies =
          filteredPharmacies.where((e) => e.isWorkingNow).toList();
    } else {
      // Если фильтр отключен, возвращаемся к полному списку аптек
      filteredPharmacies = List.from(state.pharmacies);

      // Применяем оставшиеся активные фильтры
      if (state.isShowPharmaciesProductsInStock == true) {
        filteredPharmacies = _applyProductsInStockFilter(filteredPharmacies);
      }
    }

    emit(state.copyWith(
      filteredPharmacies: filteredPharmacies,
      isShowPharmaciesWorkingNow: event.isShowPharmaciesWorkingNow,
    ));
  }

  void _onToggleShowPharmaciesProductsInStock(
      ToggleShowPharmaciesProductsInStockEvent event,
      Emitter<CartScreenState> emit) {
    List<Pharmacy> filteredPharmacies = List.from(state.filteredPharmacies);

    if (event.isShowPharmaciesProductsInStock ?? false) {
      filteredPharmacies = _applyProductsInStockFilter(filteredPharmacies);
    } else {
      // Если фильтр отключен, возвращаемся к полному списку аптек
      filteredPharmacies = List.from(state.pharmacies);

      // Применяем оставшиеся активные фильтры
      if (state.isShowPharmaciesWorkingNow == true) {
        filteredPharmacies =
            filteredPharmacies.where((e) => e.isWorkingNow).toList();
      }
    }

    emit(state.copyWith(
      filteredPharmacies: filteredPharmacies,
      isShowPharmaciesProductsInStock: event.isShowPharmaciesProductsInStock,
    ));
  }

// Вспомогательный метод для фильтрации аптек по доступности выбранных продуктов
  List<Pharmacy> _applyProductsInStockFilter(List<Pharmacy> pharmacies) {
    return pharmacies.where((pharmacy) {
      final availableProductIds =
          pharmacy.availableProducts.map((product) => product.id).toSet();
      return state.selectedProductIds
          .every((id) => availableProductIds.contains(id));
    }).toList();
  }

  // Event handlers
  Future _onToggleSelection(
      ToggleSelectionEvent event, Emitter<CartScreenState> emit) async {
    if (event.isChecked == null) return;

    final selectedProductIds = Set<int>.from(state.selectedProductIds);
    if (selectedProductIds.contains(event.productId)) {
      selectedProductIds.remove(event.productId);
    } else {
      selectedProductIds.add(event.productId);
    }

    //bool isAllProductsChecked = state.products
    //    .where((e) => e.inStock)
    //   .every((e) => selectedProductIds.contains(e.id));

    //await update();
    //emit(state.copyWith(
    //    selectedProductIds: selectedProductIds,
    //    isAllProductsChecked: isAllProductsChecked));
  }

  Future _onChangeProductCount(
      ChangeProductCountEvent event, Emitter<CartScreenState> emit) async {
    List<ProductEntity> updatedProducts = List.from(state.products);
    ProductEntity? updatedProduct =
        updatedProducts.firstWhereOrNull((e) => e.productId == event.productId);

    if (updatedProduct == null) return;

    //if (event.isIncrement) {
    //  updatedProduct.count = updatedProduct.count + 1;
    //} else {
    //  updatedProduct.count = updatedProduct.count - 1;
    //}

    // Если количество товара < 1, удаляем его из списка
    //if (updatedProduct.count < 1) {
    //  updatedProducts.removeWhere((product) => product.id == updatedProduct.id);
    //}

    await update();
    emit(state.copyWith(products: updatedProducts));
  }

  Future update() async {
    //inStockProducts = state.products
    //    .where((product) =>
    //        product.inStock &&
    //        (state.cartType == TypeReceiving.pickup || !product.isPrescription))
    //    .toList();

    //pickUpAndInStockProducts = state.products
    //    .where((product) => product.inStock && product.isPrescription)
    //    .toList();

    //noInStockProducts =
    //    state.products.where((product) => !product.inStock).toList();

    //selectedPharmacy = state.pharmacies
    //     .firstWhereOrNull((e) => e.id == state.selectedPharmacy);
  }
}

class Product {
  Product({
    required this.count,
    required this.id,
    required this.inStock,
    required this.isPrescription,
  });

  final int id;
  bool inStock = true;
  bool isPrescription = false;
  int count;
}

class Pharmacy {
  Pharmacy({
    required this.id,
    this.isWorkingNow = true,
    required this.availableProducts,
  });
  final int id;
  final bool isWorkingNow;
  final List<AvailableProducts> availableProducts;
}

class AvailableProducts {
  AvailableProducts(
      {required this.id,
      required this.count,
      required this.expiredDate,
      this.deliveryAvailable = false});
  final int id;
  final int count;
  final DateTime expiredDate;
  final bool deliveryAvailable;
}
