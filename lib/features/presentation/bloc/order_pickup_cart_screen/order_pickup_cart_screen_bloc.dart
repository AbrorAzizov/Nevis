import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/core/params/cart_for_selected_pharmacy_param.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/usecases/cart/get_order_cart.dart';
import 'package:nevis/features/domain/usecases/order/create_order_for_pickup.dart';

part 'order_pickup_cart_screen_event.dart';
part 'order_pickup_cart_screen_state.dart';

class OrderPickupCartScreenBloc
    extends Bloc<OrderPickupCartScreenEvent, OrderPickupCartScreenState> {
  final GetOrderCartProductsUC getOrderCartProductsUC;
  final CreateOrderForPickupUC createOrderForPickupUC;

  OrderPickupCartScreenBloc(
      {required this.getOrderCartProductsUC,
      required this.createOrderForPickupUC})
      : super(OrderPickupCartScreenState()) {
    on<LoadCartForSelectedPharmacyEvent>(_getCartProducts);
    on<CreateOrderForPickupEvent>(_createOrder);
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
          notAvailableCartProducts: cart.notAvailableCartItems,
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

  Future<void> _createOrder(
    CreateOrderForPickupEvent event,
    Emitter<OrderPickupCartScreenState> emit,
  ) async {
    List<CartParams> availableItems = [];
    availableItems.addAll(
      state.cartProducts
          .where((e) => e.productId != null && e.count != null)
          .map(
            (e) => CartParams(
              quantity: e.count!,
              id: e.productId!,
              offerId: e.offerId,
              availabilityStatus: 'available',
            ),
          )
          .toList(),
    );
    availableItems.addAll(
      state.cartProductsFromWarehouse
          .where((e) => e.productId != null && e.count != null)
          .map(
            (e) => CartParams(
              quantity: e.count!,
              id: e.productId!,
              offerId: e.offerId,
              availabilityStatus: 'available_on_request',
            ),
          )
          .toList(),
    );
    final failureOrLoads = await createOrderForPickupUC(availableItems);

    failureOrLoads.fold(
      (failure) {
        emit(state.copyWith(
            isLoading: false,
            errorMessage: 'Произошла ошибка',
            orderSuccessfull: false));
      },
      (orders) {
        emit(state.copyWith(orderSuccessfull: true, orders: orders));
      },
    );
  }
}
