import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/usecases/products/delete_from_favorite_products.dart';
import 'package:nevis/features/domain/usecases/products/get_favorite_products.dart';
import 'package:nevis/features/domain/usecases/products/update_favorite_products.dart';

part 'favorite_products_screen_event.dart';
part 'favorite_products_screen_state.dart';

class FavoriteProductsScreenBloc
    extends Bloc<FavoriteProductsScreenEvent, FavoriteProductsScreenState> {
  final GetFavoriteProductsUC getFavoriteProductsUC;
  final DeleteProductFromFavoriteProductsUC deleteProductFromFavoriteProductsUC;
  final UpdateFavoriteProductsUC updateFavoriteProductsUC;
  FavoriteProductsScreenBloc(
      {required this.getFavoriteProductsUC,
      required this.deleteProductFromFavoriteProductsUC,
      required this.updateFavoriteProductsUC})
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
    on<LoadFavoriteProductsEvent>(_onLoadProducts);
    on<PickAllProductsEvent>(_onPickAllProducts);
    on<ShowSortProductsTypes>(_onShowSortProductsTypes);
    on<ShowFilterProductsTypes>(_onShowFilterProductsTypes);
    on<SelectSortProductsType>(_onSelectSortProductsType);
    on<ToggleProductSelection>(_onToggleProductSelection);
    on<UpdateFavoriteProducts>(_updateFavoriteProducts);
    on<DeleteFavoriteProduct>(_deleteFavoriteProduct);

    //DeleteFavoriteProduct
  }

  Future<void> _onLoadProducts(LoadFavoriteProductsEvent event,
      Emitter<FavoriteProductsScreenState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final failureOrLoads = await getFavoriteProductsUC();
      failureOrLoads.fold(
        (_) => emit(state.copyWith(
          error: 'Ошибка загрузки данных',
          isLoading: false,
          products: [],
        )),
        (favoriteProducts) {
          emit(state.copyWith(
            products: favoriteProducts,
            isLoading: false,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _updateFavoriteProducts(
    UpdateFavoriteProducts event,
    Emitter<FavoriteProductsScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await updateFavoriteProductsUC(event.product);
    result.fold((failure) async {
      emit(state.copyWith(
        error: 'Ошибка при обновлении избранных',
        isLoading: false,
      ));
    }, (_) => add(LoadFavoriteProductsEvent()));
  }

  Future<void> _deleteFavoriteProduct(
    DeleteFavoriteProduct event,
    Emitter<FavoriteProductsScreenState> emit,
  ) async {
    final result = await deleteProductFromFavoriteProductsUC(event.productId);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          error: 'Ошибка при обновлении избранных',
          isLoading: false,
        ));
      },
      (r) async {
        final refreshed = await getFavoriteProductsUC();
        refreshed.fold(
          (failure) => emit(state.copyWith(
            error: 'Ошибка при получении обновлённого списка избранных',
            isLoading: false,
          )),
          (products) {
            emit(state.copyWith(
              products: products,
              isLoading: false,
            ));
          },
        );
      },
    );
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
    if (state.selectedFilterOrSortType == ProductFilterOrSortType.sort) {
      emit(state.copyWith(selectedFilterOrSortType: null));
    } else {
      emit(state.copyWith(
          selectedFilterOrSortType: ProductFilterOrSortType.sort));
    }
  }

  void _onShowFilterProductsTypes(ShowFilterProductsTypes event,
      Emitter<FavoriteProductsScreenState> emit) {
    if (state.selectedFilterOrSortType == ProductFilterOrSortType.filter) {
      emit(state.copyWith(selectedFilterOrSortType: null));
    } else {
      emit(state.copyWith(
          selectedFilterOrSortType: ProductFilterOrSortType.filter));
    }
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
