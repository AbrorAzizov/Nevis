import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/domain/usecases/products/get_one_product.dart';
import 'package:nevis/features/domain/usecases/products/get_product_pharmacies.dart';
import 'package:nevis/features/domain/usecases/products/get_recomendation_products.dart';

part 'product_screen_event.dart';
part 'product_screen_state.dart';

class ProductScreenBloc extends Bloc<ProductScreenEvent, ProductScreenState> {
  final GetOneProductUC getOneProductUC;
  final GetProductPharmaciesUC getProductPharmaciesUC;
  final GetRecomendationProductsUC getRecomendationProductsUC;

  PageController pageController = PageController();

  ProductScreenBloc(
      {required this.getOneProductUC,
      required this.getRecomendationProductsUC,
      required this.getProductPharmaciesUC})
      : super(ProductScreenState()) {
    on<LoadDataEvent>(_onLoadData);
  }
  void _onLoadData(
      LoadDataEvent event, Emitter<ProductScreenState> emit) async {
    String? error = 'Ошибка получения данных';
    ProductEntity? product;
    List<ProductEntity>? recomendationProducts;
    List<ProductPharmacyEntity> pharmacies = [];

    final data = await Future.wait([
      getOneProductUC(event.productId),
      getRecomendationProductsUC(event.categoryId)
    ]);

    data.forEachIndexed(
      (index, element) {
        element.fold(
          (_) {},
          (result) {
            switch (index) {
              case 0:
                product = result as ProductEntity;
                break;
              case 1:
                recomendationProducts = result as List<ProductEntity>;
            }
          },
        );
      },
    );

    if (product != null && recomendationProducts != null) error = null;
    emit(state.copyWith(
      isLoading: false,
      error: error,
      product: product,
      recomendationProducts: recomendationProducts,
      pharmacies: pharmacies,
    ));
  }
}
