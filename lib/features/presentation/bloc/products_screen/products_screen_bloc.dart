import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/category_params.dart';
import 'package:nevis/core/params/search_param.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/search_products_entity.dart';
import 'package:nevis/features/domain/usecases/products/get_category_products.dart';
import 'package:nevis/features/domain/usecases/products/get_sort_category_products.dart';
import 'package:nevis/features/domain/usecases/products/get_subcategories_products.dart';
import 'package:nevis/features/domain/usecases/search/search.dart';

part 'products_screen_event.dart';
part 'products_screen_state.dart';

class ProductsScreenBloc
    extends Bloc<ProductsScreenEvent, ProductsScreenState> {
  final GetCategoryProductsUC getCategoryProductsUC;
  final GetSortCategoryProductsUC getSortCategoryProductsUC;
  final GetSubCategoriesUC getSubCategoriesUC;
  final SearchUC searchUC;

  final CategoryParams? categoryParams;
  final List<ProductEntity>? products;
  final SearchParams? searchParams;

  ScrollController productsController = ScrollController();

  ProductsScreenBloc({
    required this.getSubCategoriesUC,
    required this.getCategoryProductsUC,
    required this.getSortCategoryProductsUC,
    required this.searchUC,
    this.products,
    this.categoryParams,
    this.searchParams,
  }) : super(ProductsScreenState()) {
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
    LoadProductsEvent event,
    Emitter<ProductsScreenState> emit,
  ) async {
    try {
      SearchProductsEntity searchProducts = state.searchProducts ??
          SearchProductsEntity(
            currentPage: 1,
            totalPage: 1,
            totalCount: products?.length ?? 0,
            products: products ?? [],
          );
      String? error;
      List<CategoryEntity> subCategories = [];

      if (searchParams != null) {
        // Новый алгоритм поиска по searchParams
        final currentPage =
            event.page ?? (state.searchProducts?.currentPage ?? 1);
        List<ProductEntity> oldProducts = [];
        if (currentPage != 1) {
          emit(state.copyWith(isLoadingProducts: true));
          oldProducts = state.searchProducts?.products ?? [];
        }
        final failureOrProducts = await searchUC(
          searchParams!.copyWith(
              page: currentPage, sort: state.selectedSortType?.searchParamName),
        );
        failureOrProducts.fold(
          (l) => error = 'Ошибка поиска товаров',
          (r) {
            searchProducts = searchProducts.copyWith(
                products: [...oldProducts, ...r.products],
                totalPage: r.lastPage,
                total: r.total,
                currentPage: currentPage);
          },
        );
        // subCategories можно не трогать или загрузить отдельно, если нужно
      } else if (categoryParams != null) {
        // ... старая логика с CategoryParams ...
        final currentPage =
            event.page ?? (state.searchProducts?.currentPage ?? 1);
        List<ProductEntity> oldProducts = [];

        if (currentPage != 1) {
          emit(state.copyWith(isLoadingProducts: true));
          oldProducts = state.searchProducts?.products ?? [];
        }

        final results = await Future.wait([
          getSortCategoryProductsUC(
            categoryParams!.copyWith(
              categoryId: int.tryParse(
                    state.selectedSubCategory?.categoryId ?? '',
                  ) ??
                  state.categoryId,
              sortBy: state.selectedSortType == ProductSortType.priceDecrease
                  ? 'desc'
                  : 'asc',
              typeOfSort: state.selectedSortType?.typeOfSort,
              page: currentPage,
            ),
          ),
          getSubCategoriesUC(categoryParams?.categoryId ?? state.categoryId!),
        ]);

        final failureOrProducts =
            results[0] as Either<Failure, SearchProductsEntity?>;
        final failureOrSubCategories =
            results[1] as Either<Failure, List<CategoryEntity>>;

        failureOrProducts.fold(
          (l) => error = 'Ошибка загрузки продуктов',
          (r) {
            if (r != null) {
              searchProducts = r.copyWith(
                products: [...oldProducts, ...r.products],
                totalPage: r.totalPage,
                currentPage: currentPage,
              );
            }
          },
        );

        failureOrSubCategories.fold(
          (l) => error = 'Ошибка загрузки подкатегорий',
          (r) => subCategories = r,
        );
      }

      // Финальный emit один на всё
      if (!isClosed) {
        emit(state.copyWith(
          isLoading: false,
          isLoadingProducts: false,
          error: error,
          searchProducts: searchProducts,
          subCategories: subCategories,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadSubCategories(
      LoadSubCategoriesEvent event, Emitter<ProductsScreenState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final failureOrLoads =
          await getSubCategoriesUC(categoryParams!.categoryId!);
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
    emit(state.copyWith(selectedSortType: event.productSortType));
    add(LoadProductsEvent(page: 1));
    try {} catch (e) {
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
          categoryParams!.copyWith(
              categoryId:
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
