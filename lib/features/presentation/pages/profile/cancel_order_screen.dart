import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_screen/order_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cancel_order_screen/cutted_order_info.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CancelOrderScreen extends StatelessWidget {
  const CancelOrderScreen({super.key});

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
              OrderScreenBloc orderBloc = context.read<OrderScreenBloc>();
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
                              title: 'Заказ №${orderState.order?.orderId}',
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
                                              Text(
                                                'Вы уверены, что хотите отменить заказ #${orderState.order?.orderId}',
                                                style: UiConstants.textStyle17,
                                              ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Text(
                                              'Отмена заказа необратима',
                                              style: UiConstants.textStyle11
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: AppButtonWidget(
                                                    text: 'Отменить заказ',
                                                    showBorder: true,
                                                    textColor:
                                                        UiConstants.blueColor,
                                                    backgroundColor: UiConstants
                                                        .backgroundColor,
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Expanded(
                                                  child: AppButtonWidget(
                                                    text: 'Вернуться',
                                                    showBorder: true,
                                                    isFilled: true,
                                                    textColor:
                                                        UiConstants.white2Color,
                                                    backgroundColor:
                                                        UiConstants.blueColor,
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            if (!orderState.isLoading)
                                              ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context,
                                                          index) =>
                                                      CuttedOrderInfo(
                                                        product: orderState
                                                            .order!
                                                            .products![index],
                                                      ),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          Divider(),
                                                  itemCount: orderState
                                                      .order!.products!.length),
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
