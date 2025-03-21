import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';

part 'favorite_products_screen_event.dart';
part 'favorite_products_screen_state.dart';

class FavoriteProductsScreenBloc
    extends Bloc<FavoriteProductsScreenEvent, FavoriteProductsScreenState> {
  FavoriteProductsScreenBloc()
      : super(
          FavoriteProductsScreenState(
            isAllProductsChecked: false,
            selectedProductIds: {},
            selectedSortType: ProductSortType.popularity,
            selectedFilterOrSortType: null,
          ),
        ) {
    on<PickAllProductsEvent>(
      (event, emit) async {
        Set<int> selectedProductIds = {};

        //if (!state.isAllProductsChecked) {
        //  selectedProductIds.addAll(state.products
        //      .where((e) => e.inStock)
        //      .map((e) => e.productId)
        //      .toList());
        //}

        emit(
          state.copyWith(
              selectedProductIds: selectedProductIds,
              isAllProductsChecked: selectedProductIds.isNotEmpty),
        );
      },
    );

    on<ShowSortProductsTypes>(
      (event, emit) async {
        emit(
          state.copyWith(
              selectedFilterOrSortType: ProductFilterOrSortType.sort),
        );
      },
    );

    on<SelectSortProductsType>(
      (event, emit) async {
        print("Выбран новый тип сортировки: ${event.productSortType}");
        emit(
          state.copyWith(selectedSortType: event.productSortType),
        );
      },
    );

    on<ToggleProductSelection>((event, emit) {
      final newSelectedProductIds = Set<int>.from(state.selectedProductIds);

      if (newSelectedProductIds.contains(event.productId)) {
        newSelectedProductIds.remove(event.productId);
      } else {
        newSelectedProductIds.add(event.productId);
      }
      emit(state.copyWith(selectedProductIds: newSelectedProductIds));
    });
  }
}
