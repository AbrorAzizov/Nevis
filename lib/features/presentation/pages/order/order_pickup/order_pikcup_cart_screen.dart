import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/params/cart_for_selected_pharmacy_param.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_pickup_cart_screen/order_pickup_cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_pickup_screen/order_pickup_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/order/order_pickup/order_pickup_success_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/cart_product_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_status_widget.dart';
import 'package:nevis/features/presentation/widgets/favourite_products_screen/selected_products_price_info_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar/search_product_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderPickupCartScreen extends StatefulWidget {
  const OrderPickupCartScreen({super.key});

  @override
  State<OrderPickupCartScreen> createState() => _OrderPickupCartScreenState();
}

class _OrderPickupCartScreenState extends State<OrderPickupCartScreen> {
  PharmacyEntity? pharmacy;
  String? storeXmlId;
  late CartScreenBloc cartBloc;
  bool _initialEventDispatched = false;

  List<CartParams> _buildCartParams(CartScreenState state) {
    return state.cartProducts
        .where(
            (e) => e.productId != null && state.counters[e.productId] != null)
        .map((e) => CartParams(
              quantity: state.counters[e.productId]!,
              id: e.productId!,
            ))
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialEventDispatched) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      pharmacy = args?['pharmacy'] as PharmacyEntity?;
      storeXmlId = pharmacy?.storeXmlId;
      cartBloc = context.read<CartScreenBloc>();

      if (pharmacy != null && storeXmlId != null) {
        final cartParams = _buildCartParams(cartBloc.state);

        context.read<OrderPickupCartScreenBloc>().add(
              LoadCartForSelectedPharmacyEvent(
                cartForSelectedPharmacyParam: CartForSelectedPharmacyParam(
                  productsFromCart: cartParams,
                  pharmacyXmlId: storeXmlId!,
                ),
              ),
            );
        _initialEventDispatched = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pharmacy == null || storeXmlId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Ошибка")),
        body: const Center(child: Text("Данные аптеки не переданы.")),
      );
    }

    return BlocListener<CartScreenBloc, CartScreenState>(
      listenWhen: (previous, current) =>
          previous.cartProducts != current.cartProducts,
      listener: (context, cartState) {
        final orderBloc = context.read<OrderPickupCartScreenBloc>();
        final orderState = orderBloc.state;

        if (orderState.orderSuccessfull == true) return;

        final cartParams = _buildCartParams(cartState);
        context.read<OrderPickupCartScreenBloc>().add(
              LoadCartForSelectedPharmacyEvent(
                cartForSelectedPharmacyParam: CartForSelectedPharmacyParam(
                  productsFromCart: cartParams,
                  pharmacyXmlId: storeXmlId!,
                ),
              ),
            );
      },
      child:
          BlocConsumer<OrderPickupCartScreenBloc, OrderPickupCartScreenState>(
        listener: (context, state) {
          if (state.orderSuccessfull ?? false) {
            Navigator.of(context).pushAndRemoveUntil(
                Routes.createRoute(
                  OrderPickupSuccessScreen(),
                  settings: RouteSettings(
                      name: Routes.bonusCardScreen,
                      arguments: {'orders': state.orders}),
                ),
                (route) => route.isFirst);

            context.read<CartScreenBloc>().add(GetCartProductsEvent());
          }
        },
        builder: (context, state) {
          final hasExceededLimit =
              state.cartProducts.any((product) => product.count! >= 50);

          return Scaffold(
            backgroundColor: UiConstants.backgroundColor,
            body: SafeArea(
              child: Skeletonizer(
                enabled: state.isLoading,
                child: Column(
                  children: [
                    const SearchProductAppBar(
                      showFavoriteProductsChip: true,
                      showLocationChip: true,
                    ),
                    Expanded(
                      child: ListView(
                        controller: cartBloc.controller,
                        padding: getMarginOrPadding(
                            bottom: 94, right: 20, left: 20, top: 16),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Корзина', style: UiConstants.textStyle17),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                child: Text(pharmacy!.address ?? '-',
                                    style: UiConstants.textStyle11),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(children: [CartStatusLabel(pharmacy: pharmacy!)]),
                          SizedBox(height: 16.h),
                          if (state.cartProducts.isNotEmpty)
                            ...state.cartProducts
                                .asMap()
                                .entries
                                .map((entry) => Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: CartProductWidget(
                                        key: ValueKey(
                                            'cart-${entry.value.productId}-${entry.key}'),
                                        cartType: CartType.pickupCart,
                                        product: entry.value,
                                        additionalEvent: () => context
                                            .read<OrderPickupScreenBloc>()
                                            .add(LoadPickupPharmaciesEvent()),
                                      ),
                                    )),
                          if (state.cartProducts.isNotEmpty)
                            SizedBox(height: 16.h),
                          if (state.cartProductsFromWarehouse.isNotEmpty) ...[
                            if (!(pharmacy!.cartStatus ==
                                    AvailabilityCartStatus.fromWareHouse &&
                                state.notAvailableCartProducts.isEmpty &&
                                state.cartProducts.isEmpty))
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Row(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: UiConstants.blueColor,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    padding: getMarginOrPadding(
                                        top: 4, bottom: 4, left: 8, right: 8),
                                    child: Text(
                                      'Под заказ со склада',
                                      style: UiConstants.textStyle8.copyWith(
                                          color: UiConstants.whiteColor),
                                    ),
                                  ),
                                ]),
                              ),
                            ...state.cartProductsFromWarehouse
                                .asMap()
                                .entries
                                .map((entry) => Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: CartProductWidget(
                                        key: ValueKey(
                                            'warehouse-${entry.value.productId}-${entry.key}'),
                                        cartType: CartType.pickupCart,
                                        product: entry.value,
                                        additionalEvent: () => context
                                            .read<OrderPickupScreenBloc>()
                                            .add(LoadPickupPharmaciesEvent()),
                                      ),
                                    )),
                            SizedBox(height: 16.h),
                          ],
                          if (state.notAvailableCartProducts.isNotEmpty) ...[
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: UiConstants.black3Color,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  padding: getMarginOrPadding(
                                      top: 4, bottom: 4, left: 8, right: 8),
                                  child: Text(
                                    'Недоступны',
                                    style: UiConstants.textStyle8.copyWith(
                                        color: UiConstants.whiteColor),
                                  ),
                                ),
                              ]),
                            ),
                            ...state.notAvailableCartProducts
                                .asMap()
                                .entries
                                .map((entry) => Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: CartProductWidget(
                                        key: ValueKey(
                                            'notavailable-${entry.value.productId}-${entry.key}'),
                                        cartType: CartType.pickupCart,
                                        product: entry.value,
                                        availabilityType:
                                            PharmacyProductsAvailabilityType
                                                .notAvailable,
                                        additionalEvent: () => context
                                            .read<OrderPickupScreenBloc>()
                                            .add(LoadPickupPharmaciesEvent()),
                                      ),
                                    )),
                            SizedBox(height: 16.h),
                          ],
                          if (state.cartProducts.isNotEmpty ||
                              state.cartProductsFromWarehouse.isNotEmpty) ...[
                            SelectedProductsPriceInformationWidget(
                              price: state.totalPrice ?? 0,
                              totalPrice: state.totalPrice ?? 0,
                              totalDiscounts: (state.totalPrice ?? 0) -
                                  (state.totalDiscounts ?? 0),
                              totalBonuses: state.totalBonuses ?? 0,
                              productsTotalCount: state.cartProducts.length,
                            ),
                            SizedBox(height: 16.h),
                          ],
                          if (hasExceededLimit)
                            Padding(
                              padding: getMarginOrPadding(bottom: 32, top: 16),
                              child: Text(
                                'Для удобства наших пользователей мы ограничили количество упаковок в одном заказе 50 шт.\n\n'
                                'Вы можете оформить упаковки сверх лимита отдельным заказом.',
                                style: UiConstants.textStyle3.copyWith(
                                  letterSpacing: 0,
                                  color:
                                      UiConstants.black3Color.withOpacity(0.6),
                                ),
                              ),
                            ),
                          AppButtonWidget(
                            text: 'Оформить самовывоз',
                            onTap: hasExceededLimit
                                ? null
                                : () => context
                                    .read<OrderPickupCartScreenBloc>()
                                    .add(CreateOrderForPickupEvent()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
