import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

part 'favorite_products_screen_event.dart';
part 'favorite_products_screen_state.dart';

class FavoriteProductsScreenBloc extends Bloc<FavoriteProductsScreenEvent, FavoriteProductsScreenState> {
  FavoriteProductsScreenBloc()
      : super(
          FavoriteProductsScreenState(
            isAllProductsChecked: false,
            selectedProductIds: {},
            selectedSortType: ProductSortType.popularity,
            selectedFilterOrSortType: null,
            products: [],
            isLoading: true, 
            error: null,
          ),
        ) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<PickAllProductsEvent>(_onPickAllProducts);
    on<ShowSortProductsTypes>(_onShowSortProductsTypes);
    on<ShowFilterProductsTypes>(_onShowFilterProductsTypes);
    on<SelectSortProductsType>(_onSelectSortProductsType);
    on<ToggleProductSelection>(_onToggleProductSelection);
  }

  Future<void> _onLoadProducts(
      LoadProductsEvent event, Emitter<FavoriteProductsScreenState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      String jsonString = await rootBundle.loadString('assets/products.json');
      final data = jsonDecode(jsonString);
      List<dynamic> dataList = data['data'];
      List<ProductEntity> products =
          dataList.map((e) => ProductModel.fromJson(e)).toList();
      emit(state.copyWith(products: products, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false,error: e.toString()));
    }
  }

 void _onPickAllProducts(
    PickAllProductsEvent event, Emitter<FavoriteProductsScreenState> emit) {
  final Set<int> newSelectedProductIds = state.isAllProductsChecked
      ? <int>{} 
      : state.products.map((e) => e.productId!).toSet();

  emit(state.copyWith(
    selectedProductIds: newSelectedProductIds,
    isAllProductsChecked: newSelectedProductIds.isNotEmpty,
  ));
}

  void _onShowSortProductsTypes(
      ShowSortProductsTypes event, Emitter<FavoriteProductsScreenState> emit) {
    emit(state.copyWith(
        selectedFilterOrSortType: ProductFilterOrSortType.sort));
  }

   void _onShowFilterProductsTypes(
      ShowFilterProductsTypes event, Emitter<FavoriteProductsScreenState> emit) {
    emit(state.copyWith(
        selectedFilterOrSortType: ProductFilterOrSortType.filter));
  }

  void _onSelectSortProductsType(
      SelectSortProductsType event, Emitter<FavoriteProductsScreenState> emit) {
    emit(state.copyWith(selectedSortType: event.productSortType));
  }

  void _onToggleProductSelection(
      ToggleProductSelection event, Emitter<FavoriteProductsScreenState> emit) {
    final newSelectedProductIds = Set<int>.from(state.selectedProductIds);
    if (newSelectedProductIds.contains(event.productId)) {
      newSelectedProductIds.remove(event.productId);
    } else {
      newSelectedProductIds.add(event.productId);
    }
    emit(state.copyWith(selectedProductIds: newSelectedProductIds));
  }
}