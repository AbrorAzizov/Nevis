import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/orders_screen/orders_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_item.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  TextEditingController searchController = TextEditingController();
  int selectorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
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
                    enabled: ordersState is OrdersScreenIsLoading,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                              hintText: 'Введите номер заказа',
                              controller: searchController,
                              title: 'Список заказов',
                              showBack: true,
                              isShowFilterButton: false,
                              onTapCancel: () {
                                searchController.clear();
                                ordersBloc.add(ShowAllLoadedOrdersEvent());
                              },
                              onChangedField: (String query) {
                                if (query.isNotEmpty) {
                                  ordersBloc.add(SearchOrderEvent(
                                      query: searchController.text));
                                } else {
                                  ordersBloc.add(ShowAllLoadedOrdersEvent());
                                }
                              },
                            ),
                            Padding(
                              padding: getMarginOrPadding(left: 20, right: 20),
                              child: BlocProvider(
                                create: (context) => SelectorCubit(
                                    index: ordersState.selectorIndex),
                                child: Selector(
                                  titlesList: const ['В работе', 'Завершенные'],
                                  onTap: (int index) => ordersBloc.add(
                                    ChangeSelectorIndexEvent(index),
                                  ),
                                ),
                              ),
                            ),
                            if (ordersState is OrdersScreenNoMatches)
                              Padding(
                                padding: getMarginOrPadding(left: 20, top: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Нет заказов по вашему запросу',
                                      style: UiConstants.textStyle10.copyWith(
                                          color: UiConstants.redColor),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  if (homeState is InternetUnavailable) {
                                    return InternetNoInternetConnectionWidget();
                                  }
                                  if (ordersState
                                          is OrdersScreenLoadedSuccessfully &&
                                      ordersState.orders.isEmpty) {
                                    return Center(
                                      child: Text(
                                        'Заказов нет',
                                        style: UiConstants.textStyle3.copyWith(
                                          color: UiConstants.darkBlueColor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    );
                                  }
                                  if (ordersState
                                      is OrdersScreenLoadedSuccessfully) {
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
                                                  order:
                                                      ordersState.orders[index],
                                                ),
                                            separatorBuilder:
                                                (context, index) =>
                                                    SizedBox(height: 8.h),
                                            itemCount:
                                                ordersState.orders.length),
                                      ],
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
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
