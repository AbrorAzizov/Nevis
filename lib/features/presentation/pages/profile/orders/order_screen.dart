import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_screen/order_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/info_border_plate.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/products_list_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_progress_indicator.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_status_widget.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_info_list.dart';
import 'package:nevis/locator_service.dart';

import 'package:skeletonizer/skeletonizer.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int? orderId = ModalRoute.of(context)?.settings.arguments! as int?;

    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        final homeBloc = context.read<HomeScreenBloc>();
        return BlocProvider(
          create: (context) =>
              OrderScreenBloc(getOneOrderUC: sl())..add(LoadDataEvent(orderId)),
          child: BlocBuilder<OrderScreenBloc, OrderScreenState>(
            builder: (context, orderState) {
              //OrderScreenBloc orderBloc = context.read<OrderScreenBloc>();
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    enabled: orderState.isLoading,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                              title: 'Заказ #${orderState.order?.orderId}',
                              showBack: true,
                              backgroundColor: UiConstants.backgroundColor,
                            ),
                            Expanded(
                              child: homeState is InternetUnavailable
                                  ? InternetNoInternetConnectionWidget()
                                  : orderState.error != null
                                      ? Center(
                                          child: Text(
                                            orderState.error ?? '',
                                            style: UiConstants.textStyle3
                                                .copyWith(
                                                    color: UiConstants
                                                        .darkBlueColor,
                                                    fontWeight:
                                                        FontWeight.w800),
                                          ),
                                        )
                                      : ListView(
                                          shrinkWrap: true,
                                          padding: getMarginOrPadding(
                                              bottom: 94,
                                              right: 20,
                                              left: 20,
                                              top: 16),
                                          children: [
                                            if (!orderState.isLoading)
                                              OrderStatusWidget(
                                                  orderStatus:
                                                      orderState.order!.status!,
                                                  date: orderState
                                                      .order!.createdAt!),
                                            SizedBox(height: 16.h),
                                            if (!orderState.isLoading)
                                              OrderProgressIndicator(
                                                  orderStatus:
                                                      orderState.order!.status!,
                                                  paymentType: orderState
                                                      .order!.paymentType!,
                                                  typeReceipt: orderState
                                                      .order!.typeReceipt!),
                                            if ((orderState.order?.products ??
                                                    [])
                                                .any((e) => e.recipe != null))
                                              Padding(
                                                padding:
                                                    getMarginOrPadding(top: 16),
                                                child: InfoBorderPlate(
                                                    imagePath:
                                                        Paths.infoIconPath,
                                                    title:
                                                        'В вашем заказе есть рецептурные препараты. Пожалуйста, не забудьте взять с собой рецепт.'),
                                              ),
                                            SizedBox(height: 32.h),
                                            ProductsListWidget(
                                                title: 'Товары',
                                                products: orderState
                                                        .order?.products ??
                                                    [],
                                                productsListScreenType:
                                                    ProductsListScreenType
                                                        .order),
                                            SizedBox(height: 32.h),
                                            BlockWidget(
                                              title: 'Информация о заказе',
                                              spacing: 8,
                                              child: OrderInfoList(
                                                  order: orderState.order),
                                            ),
                                            SizedBox(height: 32.h),
                                            if (orderState.order?.status ==
                                                OrderStatus.canceled)
                                              Padding(
                                                padding: getMarginOrPadding(
                                                    bottom: 8),
                                                child: AppButtonWidget(
                                                  text: 'Повторить заказ',
                                                  onTap: () {
                                                    homeBloc
                                                        .navigatorKeys[homeBloc
                                                            .selectedPageIndex]
                                                        .currentState!
                                                        .popUntil((route) =>
                                                            route.isFirst);

                                                    homeBloc.onChangePage(2);
                                                  },
                                                ),
                                              ),
                                            AppButtonWidget(
                                              text: 'Связаться с нами',
                                              showBorder: true,
                                              textColor:
                                                  UiConstants.purpleColor,
                                              backgroundColor:
                                                  UiConstants.backgroundColor,
                                              onTap: () {},
                                            ),
                                          ],
                                        ),
                            )
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
  }
}
