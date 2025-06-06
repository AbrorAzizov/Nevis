import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/core/params/cart_for_selected_pharmacy_param.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/usecases/cart/get_order_cart.dart';

part 'order_pickup_cart_screen_event.dart';
part 'order_pickup_cart_screen_state.dart';

class OrderPickupCartScreenBloc
    extends Bloc<OrderPickupCartScreenEvent, OrderPickupCartScreenState> {
  final GetOrderCartProductsUC getOrderCartProductsUC;

  OrderPickupCartScreenBloc({required this.getOrderCartProductsUC})
      : super(OrderPickupCartScreenState()) {
    on<LoadCartForSelectedPharmacyEvent>(_getCartProducts);
  }

  Future<void> _getCartProducts(
    LoadCartForSelectedPharmacyEvent event,
    Emitter<OrderPickupCartScreenState> emit,
  ) async {
    final failureOrLoads =
        await getOrderCartProductsUC(event.cartForSelectedPharmacyParam);

    failureOrLoads.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Произошла ошибка',
        ));
      },
      (cart) {
        emit(state.copyWith(
          isLoading: false,
          cartProductsFromWarehouse: cart.cartItemsFromWarehouse,
          cartProducts: cart.cartItems,
          totalPrice: cart.totalPrice,
          totalBonuses: cart.totalBonuses,
          deliveryAvailable: cart.deliveryAvailable,
          totalDiscounts: cart.totalDiscounts,
        ));
      },
    );
  }
}
