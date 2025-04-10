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
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/cart_product_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/empty_cart_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/favourite_products_screen/selected_products_price_info_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartScreenBloc>().add(GetCartProductsEvent());
    context.read<CartScreenBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocBuilder<CartScreenBloc, CartScreenState>(
          builder: (context, cartState) {
            CartScreenBloc cartBloc = context.read<CartScreenBloc>();
            return BlocProvider(
              create: (context) => SelectorCubit(
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
                        child: Builder(
                          builder: (context) {
                            return Column(
                              children: [
                                SearchProductAppBar(
                                  onTapLocationChip: () {},
                                  onTapFavoriteProductsChip: () {},
                                ),
                                homeState is InternetUnavailable
                                    ? InternetNoInternetConnectionWidget()
                                    : cartState.cartProducts.isNotEmpty
                                        ? Expanded(
                                            child: Builder(
                                              builder: (context) {
                                                return ListView(
                                                  controller:
                                                      cartBloc.controller,
                                                  shrinkWrap: true,
                                                  padding: getMarginOrPadding(
                                                      bottom: 94,
                                                      right: 20,
                                                      left: 20,
                                                      top: 16),
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Корзина',
                                                          style: UiConstants
                                                              .textStyle17,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            BottomSheetManager
                                                                .showClearCartSheet(
                                                                    context);
                                                          },
                                                          child: Text(
                                                            'Очистить корзину',
                                                            style: UiConstants
                                                                .textStyle3
                                                                .copyWith(
                                                                    color: UiConstants
                                                                        .black3Color
                                                                        .withOpacity(
                                                                            .6)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    Column(
                                                      children: cartState
                                                          .cartProducts
                                                          .where((product) =>
                                                              product
                                                                  .availableForDelivery ==
                                                              true)
                                                          .map(
                                                              (product) =>
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom:
                                                                            8.h),
                                                                    child: CartProductWidget(
                                                                        product:
                                                                            product),
                                                                  ))
                                                          .toList(),
                                                    ),
                                                    Builder(builder: (context) {
                                                      if (cartState.cartProducts
                                                          .any((product) =>
                                                              product
                                                                  .availableForDelivery ==
                                                              false)) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 32.h,
                                                            ),
                                                            Text(
                                                              'Недоступны для доставки',
                                                              style: UiConstants
                                                                  .textStyle5,
                                                            ),
                                                            SizedBox(
                                                              height: 16.h,
                                                            ),
                                                            Column(
                                                              children: cartState
                                                                  .cartProducts
                                                                  .where((product) =>
                                                                      product
                                                                          .availableForDelivery ==
                                                                      false)
                                                                  .map((product) =>
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 8.h),
                                                                        child: CartProductWidget(
                                                                            product:
                                                                                product),
                                                                      ))
                                                                  .toList(),
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(16
                                                                              .r),
                                                                  color: UiConstants
                                                                      .whiteColor,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Color(
                                                                              0xFF144B63)
                                                                          .withOpacity(
                                                                              0.1),
                                                                      blurRadius:
                                                                          50,
                                                                      spreadRadius:
                                                                          -4,
                                                                      offset:
                                                                          Offset(
                                                                              -1,
                                                                              -4),
                                                                    ),
                                                                  ]),
                                                              child: Padding(
                                                                padding:
                                                                    getMarginOrPadding(
                                                                        all: 8),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              color: UiConstants.blue2Color),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                getMarginOrPadding(all: 8),
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              Paths.bagIconPath,
                                                                              colorFilter: ColorFilter.mode(UiConstants.blueColor, BlendMode.srcIn),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              8.w,
                                                                        ),
                                                                        Text(
                                                                          'Оформить самовывоз',
                                                                          style:
                                                                              UiConstants.textStyle21,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    RotatedBox(
                                                                        quarterTurns:
                                                                            1,
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          Paths
                                                                              .dropdownArrowIconPath,
                                                                          colorFilter: ColorFilter.mode(
                                                                              UiConstants.blueColor,
                                                                              BlendMode.srcIn),
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      }
                                                      return SizedBox.shrink();
                                                    }),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    SelectedProductsPriceInformationWidget(
                                                      products: cartState
                                                          .cartProducts,
                                                    ),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    if (cartState.cartProducts
                                                        .any((product) =>
                                                            product
                                                                .availableForDelivery ==
                                                            false))
                                                      Text(
                                                        'Доставка на дом недоступна для некоторых товаров',
                                                        style: UiConstants
                                                            .textStyle3
                                                            .copyWith(
                                                                color: UiConstants
                                                                    .black3Color
                                                                    .withOpacity(
                                                                        .6)),
                                                      )
                                                    else
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Способ получения заказа',
                                                            style: UiConstants
                                                                .textStyle20,
                                                          ),
                                                          SizedBox(height: 8.h),
                                                          Selector(
                                                            titlesList: const [
                                                              'Доставка на дом',
                                                              'Самовывоз'
                                                            ],
                                                            onTap:
                                                                (int index) =>
                                                                    cartBloc
                                                                        .add(
                                                              ChangeSelectorIndexEvent(
                                                                TypeReceiving
                                                                        .values[
                                                                    index],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    if (cartState
                                                        .counters.values
                                                        .any((count) =>
                                                            count >= 50))
                                                      Padding(
                                                        padding:
                                                            getMarginOrPadding(
                                                                bottom: 32,
                                                                top: 16),
                                                        child: Text(
                                                          'Для удобства наших пользователей мы ограничили количество упаковок в одном заказе 50 шт.\n\nВы можете оформить упаковки сверх лимита отдельным заказом.',
                                                          style: UiConstants
                                                              .textStyle3
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      0,
                                                                  color: UiConstants
                                                                      .black3Color
                                                                      .withOpacity(
                                                                          .6)),
                                                        ),
                                                      ),
                                                    AppButtonWidget(
                                                      text: 'Оформить заказ',
                                                      onTap: cartState
                                                              .counters.values
                                                              .any((count) =>
                                                                  count >= 50)
                                                          ? null
                                                          : () {
                                                              if (cartState
                                                                  .cartProducts
                                                                  .any((product) =>
                                                                      product
                                                                          .availableForDelivery ==
                                                                      false)) {
                                                                BottomSheetManager
                                                                    .showWarningAboutNonDeliveryProduct(
                                                                        context);
                                                              }
                                                            },
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          )
                                        : Expanded(child: EmptyCartWidget())
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
