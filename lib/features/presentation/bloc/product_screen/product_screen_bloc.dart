import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/domain/usecases/products/get_one_product.dart';
import 'package:nevis/features/domain/usecases/products/get_product_pharmacies.dart';

part 'product_screen_event.dart';
part 'product_screen_state.dart';

class ProductScreenBloc extends Bloc<ProductScreenEvent, ProductScreenState> {
  final int? productId;
  final GetOneProductUC getOneProductUC;
  final GetProductPharmaciesUC getProductPharmaciesUC;

  PageController pageController = PageController();

  ProductScreenBloc(
      {this.productId,
      required this.getOneProductUC,
      required this.getProductPharmaciesUC})
      : super(ProductScreenState()) {
    on<LoadDataEvent>(_onLoadData);
  }

  void _onLoadData(
      LoadDataEvent event, Emitter<ProductScreenState> emit) async {
    String? error = 'Ошибка получения данных';
    ProductEntity? product;
    List<ProductPharmacyEntity> pharmacies = [];

    if (productId != null) {
      var data = await Future.wait(
        [
          getOneProductUC(productId!),
          getProductPharmaciesUC(productId!),
        ],
      );

      data.forEachIndexed(
        (index, element) {
          element.fold(
            (_) {},
            (result) => switch (index) {
              0 => product = result as ProductEntity,
              1 => pharmacies = result as List<ProductPharmacyEntity>,
              _ => {},
            },
          );
        },
      );

      if (product != null) error = null;
    }

    emit(
      ProductScreenState(
          isLoading: false,
          error: error,
          product: product,
          pharmacies: pharmacies),
    );
  }
}
