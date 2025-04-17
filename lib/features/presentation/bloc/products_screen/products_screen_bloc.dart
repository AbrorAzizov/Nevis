import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/params/category_params.dart';
import 'package:nevis/features/domain/usecases/products/get_category_products.dart';
import 'package:nevis/features/domain/usecases/products/get_sort_category_products.dart';
import 'package:nevis/features/domain/usecases/products/get_subcategories_products.dart';

part 'products_screen_event.dart';
part 'products_screen_state.dart';

class ProductsScreenBloc
    extends Bloc<ProductsScreenEvent, ProductsScreenState> {
  final GetCategoryProductsUC getCategoryProductsUC;
  final GetSortCategoryProductsUC getSortCategoryProductsUC;
  final GetSubCategoriesUC getSubCategoriesUC;
  ProductsScreenBloc(
      {required this.getSubCategoriesUC,
      required this.getCategoryProductsUC,
      required this.getSortCategoryProductsUC})
      : super(
          ProductsScreenState(
            selectedSortType: ProductSortType.popularity,
            selectedFilterOrSortType: null,
            products: [],
            isLoading: true,
            selectedSubCategory: null,
            error: null,
            subCategories: [],
          ),
        ) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<ShowSortProductsTypes>(_onShowSortProductsTypes);
    on<ShowFilterProductsTypes>(_onShowFilterProductsTypes);
    on<SelectSortProductsType>(_onSelectSortProductsType);
    on<LoadSubCategoriesEvent>(_onLoadSubCategories);
    on<SelectSubCategoryEvent>(_onSelectSubCategory);
  }

  Future<void> _onLoadProducts(
      LoadProductsEvent event, Emitter<ProductsScreenState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final results = await Future.wait([
        getCategoryProductsUC(event.categoryId),
        getSubCategoriesUC(event.categoryId),
      ]);

      final failureOrProducts =
          results[0] as Either<Failure, List<ProductEntity>>;
      final failureOrSubCategories =
          results[1] as Either<Failure, List<CategoryEntity>>;

      String? error;
      List<ProductEntity> products = [];
      List<CategoryEntity> subCategories = [];

      failureOrProducts.fold(
        (l) => error = 'Ошибка загрузки продуктов',
        (r) => products = r,
      );

      failureOrSubCategories.fold(
        (l) => error = 'Ошибка загрузки подкатегорий',
        (r) => subCategories = r,
      );

      emit(state.copyWith(
        isLoading: false,
        error: error,
        products: products,
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
      final failureOrLoads = await getSortCategoryProductsUC(CategoryParams(
          categotyId: event.categoryId,
          sortBy: event.productSortType == ProductSortType.priceDecrease
              ? 'desc'
              : 'asc',
          typeOfSort: event.productSortType.typeOfSort));
      failureOrLoads.fold(
          (_) => emit(
              state.copyWith(isLoading: false, error: 'Something went wrong')),
          (products) =>
              emit(state.copyWith(products: products, isLoading: false)));
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
            categotyId: int.parse(event.subCategory.categoryId ?? '0'),
            sortBy: state.selectedSortType == ProductSortType.priceDecrease
                ? 'desc'
                : 'asc',
            typeOfSort: state.selectedSortType?.typeOfSort ?? '',
          ),
        );

        failureOrProducts.fold(
          (_) =>
              emit(state.copyWith(isLoading: false, error: 'Ошибка загрузки')),
          (products) =>
              emit(state.copyWith(products: products, isLoading: false)),
        );
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    } else {
      emit(state.copyWith(isLoading: true));
    }
  }
}
