import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/search_products_entity.dart';
import 'package:nevis/features/domain/params/category_params.dart';
import 'package:nevis/features/domain/usecases/products/get_category_products.dart';
import 'package:nevis/features/domain/usecases/products/get_sort_category_products.dart';
import 'package:nevis/features/domain/usecases/products/get_subcategories_products.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/locator_service.dart';

part 'products_screen_event.dart';
part 'products_screen_state.dart';

class ProductsScreenBloc
    extends Bloc<ProductsScreenEvent, ProductsScreenState> {
  final GetCategoryProductsUC getCategoryProductsUC;
  final GetSortCategoryProductsUC getSortCategoryProductsUC;
  final GetSubCategoriesUC getSubCategoriesUC;

  final int? categoryId;
  final List<ProductEntity>? products;

  ScrollController productsController = ScrollController();

  ProductsScreenBloc({
    required this.getSubCategoriesUC,
    required this.getCategoryProductsUC,
    required this.getSortCategoryProductsUC,
    this.products,
    this.categoryId,
  }) : super(ProductsScreenState(categoryId: categoryId)) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<ShowSortProductsTypes>(_onShowSortProductsTypes);
    on<ShowFilterProductsTypes>(_onShowFilterProductsTypes);
    on<SelectSortProductsType>(_onSelectSortProductsType);
    on<LoadSubCategoriesEvent>(_onLoadSubCategories);
    on<SelectSubCategoryEvent>(_onSelectSubCategory);

    // Добавляем слушатель для скролла
    if (products == null) productsController.addListener(_scrollListener);
  }

  void _scrollListener() {
    print("ScrollListener triggered"); // Печатаем, чтобы проверить срабатывание
    // Если скроллинг достиг нижней границы, загружаем следующую страницу
    if (productsController.position.pixels ==
        productsController.position.maxScrollExtent) {
      if (state.searchProducts!.currentPage < state.searchProducts!.totalPage) {
        // Загружаем следующую страницу
        add(LoadProductsEvent(page: state.searchProducts!.currentPage + 1));
      }
    }
  }

  Future<void> _onLoadProducts(
      LoadProductsEvent event, Emitter<ProductsScreenState> emit) async {
    try {
      int currentPage = event.page ?? (state.searchProducts?.currentPage ?? 1);
      List<ProductEntity> oldProducts = [];

      if (currentPage != 1) {
        emit(state.copyWith(isLoadingProducts: true));
        oldProducts = state.searchProducts?.products ?? [];
      }

      final results = await Future.wait([
        getSortCategoryProductsUC(CategoryParams(
            categotyId:
                int.tryParse(state.selectedSubCategory?.categoryId ?? '') ??
                    state.categoryId!,
            sortBy: state.selectedSortType == ProductSortType.priceDecrease
                ? 'desc'
                : 'asc',
            typeOfSort: state.selectedSortType!.typeOfSort,
            page: currentPage)),
        getSubCategoriesUC(state.categoryId!),
      ]);

      final failureOrProducts =
          results[0] as Either<Failure, SearchProductsEntity?>;
      final failureOrSubCategories =
          results[1] as Either<Failure, List<CategoryEntity>>;

      String? error;
      SearchProductsEntity? searchProducts;
      List<CategoryEntity> subCategories = [];

      failureOrProducts.fold(
        (l) => error = 'Ошибка загрузки продуктов',
        (r) {
          searchProducts = r;

          // Объединяем старые продукты с новыми
          final updatedProducts = List<ProductEntity>.from(oldProducts)
            ..addAll(
              (r?.products ?? []).map((product) {
                print(sl<FavoriteProductsScreenBloc>().state.isLoading);
                bool? isFav = sl<FavoriteProductsScreenBloc>()
                    .state
                    .products
                    .any((favProduct) =>
                        favProduct.productId == product.productId);
                return product.copyWith(isFav: isFav);
              }),
            );

          searchProducts = searchProducts?.copyWith(products: updatedProducts);
        },
      );

      failureOrSubCategories.fold(
        (l) => error = 'Ошибка загрузки подкатегорий',
        (r) => subCategories = r,
      );

      emit(state.copyWith(
        isLoading: false,
        isLoadingProducts: false,
        error: error,
        searchProducts: searchProducts,
        subCategories: subCategories,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadSubCategories(
      LoadSubCategoriesEvent event, Emitter<ProductsScreenState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final failureOrLoads = await getSubCategoriesUC(event.categoryId);
      failureOrLoads.fold(
          (_) => emit(
              state.copyWith(isLoading: false, error: 'Something went wrong')),
          (subCategories) => emit(
              state.copyWith(subCategories: subCategories, isLoading: false)));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onShowSortProductsTypes(
      ShowSortProductsTypes event, Emitter<ProductsScreenState> emit) {
    if (state.selectedFilterOrSortType == ProductFilterOrSortType.sort) {
      emit(state.copyWith(selectedFilterOrSortType: null));
    } else {
      emit(state.copyWith(
          selectedFilterOrSortType: ProductFilterOrSortType.sort));
    }
  }

  void _onShowFilterProductsTypes(
      ShowFilterProductsTypes event, Emitter<ProductsScreenState> emit) {
    if (state.selectedFilterOrSortType == ProductFilterOrSortType.filter) {
      emit(state.copyWith(selectedFilterOrSortType: null));
    } else {
      emit(state.copyWith(
          selectedFilterOrSortType: ProductFilterOrSortType.filter));
    }
  }

  void _onSelectSortProductsType(
      SelectSortProductsType event, Emitter<ProductsScreenState> emit) async {
    emit(state.copyWith(
        selectedSortType: event.productSortType, isLoading: true));
    try {
      final failureOrLoads = await getSortCategoryProductsUC(
        CategoryParams(
            categotyId:
                int.tryParse(state.selectedSubCategory?.categoryId ?? '') ??
                    event.categoryId,
            sortBy: event.productSortType == ProductSortType.priceDecrease
                ? 'desc'
                : 'asc',
            typeOfSort: event.productSortType.typeOfSort,
            page: 1),
      );
      failureOrLoads.fold(
          (_) => emit(
              state.copyWith(isLoading: false, error: 'Something went wrong')),
          (products) =>
              emit(state.copyWith(searchProducts: products, isLoading: false)));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onSelectSubCategory(
      SelectSubCategoryEvent event, Emitter<ProductsScreenState> emit) async {
    final currentSubCategory = state.selectedSubCategory;
    if (currentSubCategory != event.subCategory) {
      emit(state.copyWith(
          selectedSubCategory: event.subCategory, isLoading: true));
      try {
        final failureOrProducts = await getSortCategoryProductsUC(
          CategoryParams(
              categotyId:
                  int.tryParse(state.selectedSubCategory?.categoryId ?? '') ??
                      state.categoryId!,
              sortBy: state.selectedSortType == ProductSortType.priceDecrease
                  ? 'desc'
                  : 'asc',
              typeOfSort: state.selectedSortType?.typeOfSort ?? '',
              page: 1),
        );

        failureOrProducts.fold(
          (_) =>
              emit(state.copyWith(isLoading: false, error: 'Ошибка загрузки')),
          (products) =>
              emit(state.copyWith(searchProducts: products, isLoading: false)),
        );
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    } else {
      emit(state.copyWith(isLoading: true));
    }
  }
}
