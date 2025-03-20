import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_products_screen_event.dart';
part 'favorite_products_screen_state.dart';

class FavoriteProductsScreenBloc
    extends Bloc<FavoriteProductsScreenEvent, FavoriteProductsScreenState> {
  FavoriteProductsScreenBloc()
      : super(
          FavoriteProductsScreenState(
            isAllProductsChecked: false,
            selectedProductIds: {},
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
  }
}
