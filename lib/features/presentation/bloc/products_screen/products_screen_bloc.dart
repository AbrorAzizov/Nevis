import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/usecases/products/get_category_products.dart';

part 'products_screen_event.dart';
part 'products_screen_state.dart';

class ProductsScreenBloc
    extends Bloc<ProductsScreenEvent, ProductsScreenState> {
  final GetCategoryProductsUC getCategoryProductsUC;
  ProductsScreenBloc({required this.getCategoryProductsUC})
      : super(
          ProductsScreenState(
            selectedSortType: ProductSortType.popularity,
            selectedFilterOrSortType: null,
            products: [],
            isLoading: true,
            error: null,
          ),
        ) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<ShowSortProductsTypes>(_onShowSortProductsTypes);
    on<ShowFilterProductsTypes>(_onShowFilterProductsTypes);
    on<SelectSortProductsType>(_onSelectSortProductsType);
  }

  Future<void> _onLoadProducts(
      LoadProductsEvent event, Emitter<ProductsScreenState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final failureOrLoads = await getCategoryProductsUC(event.categoryId);
      failureOrLoads.fold(
          (_) => emit(
              state.copyWith(isLoading: false, error: 'Something went wrong')),
          (products) =>
              emit(state.copyWith(products: products, isLoading: false)));
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
      SelectSortProductsType event, Emitter<ProductsScreenState> emit) {
    emit(state.copyWith(selectedSortType: event.productSortType));
  }
}
