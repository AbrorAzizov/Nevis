import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/bottom_sheet_manager.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/orders_screen/orders_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_item.dart';
import 'package:nevis/locator_service.dart';

import 'package:skeletonizer/skeletonizer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        HomeScreenBloc homeBloc = context.read<HomeScreenBloc>();
        return BlocProvider(
          create: (context) =>
              OrdersScreenBloc(getOrderHistoryUC: sl())..add(LoadDataEvent()),
          child: BlocBuilder<OrdersScreenBloc, OrdersScreenState>(
            builder: (context, ordersState) {
              OrdersScreenBloc ordersBloc = context.read<OrdersScreenBloc>();
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    enabled: ordersState.isLoading,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                              hintText: 'Искать по заказам',
                              controller: TextEditingController(),
                              title: 'Список заказов',
                              showBack: true,
                              isShowFilterButton: true,
                              onTapFilterButton: () =>
                                  BottomSheetManager.showOrdersFilterSheet(
                                      homeBloc.context, context),
                            ),
                            Expanded(
                              child: homeState is InternetUnavailable
                                  ? InternetNoInternetConnectionWidget()
                                  : Builder(builder: (context) {
                                      List<OrderEntity> orders = List.from(
                                          ordersState.filteredOrders ?? []);

                                      if (ordersState.isOnlyActive!) {
                                        orders = orders
                                            .where((e) => [
                                                  OrderStatus.onTheWay,
                                                  OrderStatus.readyToIssue
                                                ].contains(e.status))
                                            .toList();
                                      }
                                      if ((ordersState.orders ?? []).isEmpty) {
                                        return Center(
                                          child: Text(
                                            'Заказов нет',
                                            style: UiConstants.textStyle3
                                                .copyWith(
                                                    color: UiConstants
                                                        .darkBlueColor,
                                                    fontWeight:
                                                        FontWeight.w800),
                                          ),
                                        );
                                      }

                                      return ListView(
                                        shrinkWrap: true,
                                        padding: getMarginOrPadding(
                                            bottom: 94,
                                            right: 20,
                                            left: 20,
                                            top: 16),
                                        children: [
                                          ListView.separated(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) =>
                                                  OrderItem(
                                                      order: orders[index]),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 8.h),
                                              itemCount: orders.length)
                                        ],
                                      );
                                    }),
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
