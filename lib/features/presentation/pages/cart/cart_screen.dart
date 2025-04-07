import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/cart_product_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocBuilder<CartScreenBloc, CartScreenState>(
          builder: (context, cartState) {
            CartScreenBloc cartBloc = context.read<CartScreenBloc>()
              ..add(GetCartProductsEvent());
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
                                    : cartState.products.isNotEmpty
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
                                                        Text(
                                                          'Очистить корзину',
                                                          style: UiConstants
                                                              .textStyle3
                                                              .copyWith(
                                                                  color: UiConstants
                                                                      .black3Color
                                                                      .withOpacity(
                                                                          .6)),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                        spacing: 8.h,
                                                        children: List.generate(
                                                            cartState.products
                                                                .length,
                                                            (index) {
                                                          return CartProductWidget(
                                                              product: cartState
                                                                      .products[
                                                                  index]);
                                                        }))
                                                  ],
                                                );
                                              },
                                            ),
                                          )
                                        : Expanded(
                                            child: Padding(
                                              padding: getMarginOrPadding(
                                                  left: 20, right: 20, top: 16),
                                              child: Column(
                                                children: [
                                                  // селектор доставка/самовывоз
                                                  // Align(
                                                  //   alignment:
                                                  //       AlignmentDirectional
                                                  //           .center,
                                                  //   child: Selector(
                                                  //     titlesList: const [
                                                  //       'Доставка',
                                                  //       'Самовывоз'
                                                  //     ],
                                                  //     onTap: (int index) =>
                                                  //         cartBloc.add(
                                                  //       ChangeCartTypeEvent(
                                                  //         TypeReceiving
                                                  //             .values[index],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
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
