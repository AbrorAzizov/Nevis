import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/bottom_sheet_manager.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/cart_product_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/empty_cart_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/favourite_products_screen/selected_products_price_info_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartScreenBloc, CartScreenState>(
      bloc: sl<CartScreenBloc>(),
      builder: (context, cartState) {
        final cartBloc = context.read<CartScreenBloc>();
        final hasUnavailable =
            cartState.cartProducts.any((p) => p.availableForDelivery == false);
        final availableProducts = cartState.cartProducts
            .where((p) => p.availableForDelivery == true)
            .toList();
        final unavailableProducts = cartState.cartProducts
            .where((p) => p.availableForDelivery == false)
            .toList();

        return BlocProvider(
          create: (_) => SelectorCubit(
            index: [TypeReceiving.delivery, TypeReceiving.pickup]
                .indexOf(cartState.cartType),
          ),
          child: BlocBuilder<SelectorCubit, SelectorState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    enabled: cartState.isLoading,
                    child: Column(
                      children: [
                        SearchProductAppBar(
                          showFavoriteProductsChip: true,
                          showLocationChip: true,
                        ),
                        cartState.cartProducts.isNotEmpty
                            ? Expanded(
                                child: ListView(
                                  controller: cartBloc.controller,
                                  shrinkWrap: true,
                                  padding: getMarginOrPadding(
                                      bottom: 94, right: 20, left: 20, top: 16),
                                  children: [
                                    // Заголовок и кнопка очистки
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Корзина',
                                            style: UiConstants.textStyle17),
                                        GestureDetector(
                                          onTap: () => BottomSheetManager
                                              .showClearCartSheet(context),
                                          child: Text(
                                            'Очистить корзину',
                                            style:
                                                UiConstants.textStyle3.copyWith(
                                              color: UiConstants.black3Color
                                                  .withOpacity(.6),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.h),

                                    ...availableProducts
                                        .map((product) => Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8.h),
                                              child: CartProductWidget(
                                                  product: product),
                                            )),

                                    if (hasUnavailable) ...[
                                      SizedBox(height: 32.h),
                                      Text('Недоступны для доставки',
                                          style: UiConstants.textStyle5),
                                      SizedBox(height: 16.h),
                                      ...unavailableProducts
                                          .map((product) => Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 8.h),
                                                child: CartProductWidget(
                                                    product: product),
                                              )),
                                      SizedBox(height: 12),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          color: UiConstants.whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF144B63)
                                                  .withOpacity(0.1),
                                              blurRadius: 50,
                                              spreadRadius: -4,
                                              offset: const Offset(-1, -4),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: getMarginOrPadding(all: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: UiConstants
                                                          .blue2Color,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          getMarginOrPadding(
                                                              all: 8),
                                                      child: SvgPicture.asset(
                                                        Paths.bagIconPath,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                UiConstants
                                                                    .blueColor,
                                                                BlendMode
                                                                    .srcIn),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Text('Оформить самовывоз',
                                                      style: UiConstants
                                                          .textStyle21),
                                                ],
                                              ),
                                              RotatedBox(
                                                quarterTurns: 1,
                                                child: SvgPicture.asset(
                                                  Paths.dropdownArrowIconPath,
                                                  colorFilter: ColorFilter.mode(
                                                      UiConstants.blueColor,
                                                      BlendMode.srcIn),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],

                                    SizedBox(height: 16.h),

                                    // Цена
                                    SelectedProductsPriceInformationWidget(
                                      totalPrice: cartState.totalPrice ?? 0,
                                      totalDiscounts:
                                          cartState.totalDiscounts ?? 0,
                                      totalBonuses: cartState.totalBonuses ?? 0,
                                      productsTotalCount:
                                          cartState.cartProducts.length,
                                    ),
                                    SizedBox(height: 16.h),

                                    if (hasUnavailable)
                                      Text(
                                        'Доставка на дом недоступна для некоторых товаров',
                                        style: UiConstants.textStyle3.copyWith(
                                            color: UiConstants.black3Color
                                                .withOpacity(.6)),
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Способ получения заказа',
                                              style: UiConstants.textStyle20),
                                          SizedBox(height: 8.h),
                                          Selector(
                                            titlesList: const [
                                              'Доставка на дом',
                                              'Самовывоз'
                                            ],
                                            onTap: (int index) => cartBloc.add(
                                              ChangeSelectorIndexEvent(
                                                  TypeReceiving.values[index]),
                                            ),
                                          ),
                                        ],
                                      ),

                                    if (cartState.counters.values
                                        .any((count) => count >= 50))
                                      Padding(
                                        padding: getMarginOrPadding(
                                            bottom: 32, top: 16),
                                        child: Text(
                                          'Для удобства наших пользователей мы ограничили количество упаковок в одном заказе 50 шт.\n\n'
                                          'Вы можете оформить упаковки сверх лимита отдельным заказом.',
                                          style:
                                              UiConstants.textStyle3.copyWith(
                                            letterSpacing: 0,
                                            color: UiConstants.black3Color
                                                .withOpacity(.6),
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppButtonWidget(
                                      text: 'Оформить заказ',
                                      onTap: cartState.counters.values
                                              .any((count) => count >= 50)
                                          ? null
                                          : () {
                                              if (hasUnavailable) {
                                                BottomSheetManager
                                                    .showWarningAboutNonDeliveryProduct(
                                                        context);
                                              }
                                            },
                                    ),
                                  ],
                                ),
                              )
                            : const Expanded(child: EmptyCartWidget()),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
