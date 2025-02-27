import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/core/params/product_param.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/usecases/products/search_products.dart';

part 'products_screen_event.dart';
part 'products_screen_state.dart';

class ProductsScreenBloc
    extends Bloc<ProductsScreenEvent, ProductsScreenState> {
  final SearchProductsUC searchProductsUC;

  ProductsScreenBloc({required this.searchProductsUC})
      : super(
          ProductsScreenState(productSortType: ProductSortType.popularity),
        ) {
    on<LoadDataEvent>(_onLoadData);
    on<ChangeProductSortTypeEvent>(_onChangeProductSortTypeEvent);
  }

  void _onChangeProductSortTypeEvent(
      ChangeProductSortTypeEvent event, Emitter<ProductsScreenState> emit) {
    emit(state.copyWith(productSortType: event.productSortType));
  }

  void _onLoadData(
      LoadDataEvent event, Emitter<ProductsScreenState> emit) async {
    List<ProductEntity> products = event.products ?? [];
    String? error;

    if (event.productParam != null) {
      final failureOrLoads = await searchProductsUC(event.productParam!);

      return failureOrLoads.fold(
        (_) => error = 'Ошибка получения данных',
        (productList) {
          products = productList;
          emit(
            ProductsScreenState(
                isLoading: false,
                error: null,
                productSortType: ProductSortType.popularity,
                products: products),
          );
        },
      );
    }

    emit(
      ProductsScreenState(isLoading: false, error: error, products: products),
    );
  }
}
