import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/params/cart_for_selected_pharmacy_param.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_pickup_cart_screen/order_pickup_cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_pickup_screen/order_pickup_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/cart_product_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_status_widget.dart';
import 'package:nevis/features/presentation/widgets/favourite_products_screen/selected_products_price_info_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderPickupCartScreen extends StatelessWidget {
  const OrderPickupCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final pharmacy = args?['pharmacy'] as PharmacyEntity?;
    final storeXmlId = pharmacy?.storeXmlId;
    final cartBloc = context.read<CartScreenBloc>();

    if (pharmacy == null || storeXmlId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Ошибка")),
        body: const Center(
          child: Text("Данные аптеки не переданы."),
        ),
      );
    }

    final productsFromCart = cartBloc.state.cartProducts
        .where((e) =>
            e.productId != null && cartBloc.state.counters[e.productId] != null)
        .map((e) => CartParams(
              quantity: cartBloc.state.counters[e.productId]!,
              id: e.productId!,
            ))
        .toList();

    context.read<OrderPickupCartScreenBloc>().add(
          LoadCartForSelectedPharmacyEvent(
            cartForSelectedPharmacyParam: CartForSelectedPharmacyParam(
              productsFromCart: productsFromCart,
              pharmacyXmlId: storeXmlId,
            ),
          ),
        );

    return BlocListener<CartScreenBloc, CartScreenState>(
      listenWhen: (previous, current) =>
          previous.cartProducts != current.cartProducts,
      listener: (context, cartState) {
        final updatedProductsFromCart = cartState.cartProducts
            .where((e) =>
                e.productId != null && cartState.counters[e.productId] != null)
            .map((e) => CartParams(
                  quantity: cartState.counters[e.productId]!,
                  id: e.productId!,
                ))
            .toList();

        context.read<OrderPickupCartScreenBloc>().add(
              LoadCartForSelectedPharmacyEvent(
                cartForSelectedPharmacyParam: CartForSelectedPharmacyParam(
                  productsFromCart: updatedProductsFromCart,
                  pharmacyXmlId: storeXmlId,
                ),
              ),
            );
      },
      child: BlocBuilder<OrderPickupCartScreenBloc, OrderPickupCartScreenState>(
        builder: (context, orderCartState) {
          final hasExceededLimit = orderCartState.cartProducts
              .any((product) => product.count! >= 50);

          return Scaffold(
            backgroundColor: UiConstants.backgroundColor,
            body: SafeArea(
              child: Skeletonizer(
                enabled: orderCartState.isLoading,
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
                          bottom: 94,
                          right: 20,
                          left: 20,
                          top: 16,
                        ),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Корзина', style: UiConstants.textStyle17),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CartStatusLabel(pharmacy: pharmacy),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          ...orderCartState.cartProducts.asMap().entries.map(
                            (entry) {
                              final index = entry.key;
                              final product = entry.value;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: CartProductWidget(
                                  key: ValueKey(
                                      'cart-${product.productId}-$index'),
                                  cartType: CartType.pickupCart,
                                  product: product,
                                  additionalEvent: () {
                                    context
                                        .read<OrderPickupScreenBloc>()
                                        .add(LoadPickupPharmaciesEvent());
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 16.h),
                          Text('СОСКЛАДА'),
                          ...orderCartState.cartProductsFromWarehouse
                              .asMap()
                              .entries
                              .map(
                            (entry) {
                              final index = entry.key;
                              final product = entry.value;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: CartProductWidget(
                                  key: ValueKey(
                                      'warehouse-${product.productId}-$index'),
                                  cartType: CartType.pickupCart,
                                  product: product,
                                  additionalEvent: () {
                                    context
                                        .read<OrderPickupScreenBloc>()
                                        .add(LoadPickupPharmaciesEvent());
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 16.h),
                          SelectedProductsPriceInformationWidget(
                            totalPrice: orderCartState.totalPrice ?? 0,
                            totalDiscounts: orderCartState.totalDiscounts ?? 0,
                            totalBonuses: orderCartState.totalBonuses ?? 0,
                            productsTotalCount:
                                orderCartState.cartProducts.length,
                          ),
                          SizedBox(height: 16.h),
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
                          SizedBox(height: 16.h),
                          AppButtonWidget(
                            text: 'Оформить самовывоз',
                            onTap: hasExceededLimit ? null : () {},
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
