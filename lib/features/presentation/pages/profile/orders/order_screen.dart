import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_screen/order_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/profile/cancel_order.screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/products_list_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_progress_indicator.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_screen_buy_info.dart';
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
                              onChangedField: (String query){
                                
                              },
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
                                              top: 20),
                                          children: [
                                            if (!orderState.isLoading &&
                                                orderState.order!.status ==
                                                    OrderStatus.canceled)
                                              Image.asset(
                                                Paths.canceledOrderIconPath,
                                                width: 133,
                                                height: 133,
                                              ),
                                            if (!orderState.isLoading)
                                              OrderStatusWidget(
                                                  orderStatus:
                                                      orderState.order!.status!,
                                                  date: orderState
                                                      .order!.createdAt!),
                                            (!orderState.isLoading &&
                                                    orderState.order!.status ==
                                                        OrderStatus.canceled)
                                                ? SizedBox.shrink()
                                                : SizedBox(
                                                    height: 32.h,
                                                  ),
                                            if (!orderState.isLoading &&
                                                orderState.order!.status !=
                                                    OrderStatus.canceled &&
                                                orderState.order!.status !=
                                                    OrderStatus.received)
                                              OrderProgressIndicator(
                                                  orderStatus:
                                                      orderState.order!.status!,
                                                  paymentType: orderState
                                                      .order!.paymentType!,
                                                  typeReceipt: orderState
                                                      .order!.typeReceipt!),
                                            SizedBox(height: 32.h),
                                            if (!orderState.isLoading &&
                                                orderState.order!.typeReceipt !=
                                                    TypeReceiving.delivery &&  orderState.order!.status == OrderStatus.readyToIssue  )
                                              Padding(
                                                padding: getMarginOrPadding(bottom: 16),
                                                child: Text(
                                                    'Можете оплатить сейчас или при получении',
                                                    textAlign: TextAlign.center,
                                                    style: UiConstants.textStyle2,),
                                              ),
                                            if(!orderState.isLoading &&(orderState.order!.status == OrderStatus.accepted ||  orderState.order!.status == OrderStatus.readyToIssue) && orderState.order!.typeReceipt != TypeReceiving.delivery )
                                              Padding(
                                                padding: getMarginOrPadding(bottom: 32),
                                                child: AppButtonWidget(
                                                              text:
                                                                  'Перейти к оплате',
                                                              showBorder: false,
                                                              
                                                              textColor:
                                                              orderState.order!.status == OrderStatus.accepted?    UiConstants
                                                                      .black3Color.withOpacity(0.6) : UiConstants.whiteColor,
                                                              backgroundColor:
                                                              orderState.order!.status == OrderStatus.accepted ?
                                                                  UiConstants
                                                                      .black3Color.withOpacity(0.05) : UiConstants.blueColor,
                                                              onTap:    orderState.order!.status == OrderStatus.accepted?  null : (){},
                                                            ),
                                              ),
                                              if(!orderState.isLoading && orderState.order!.status == OrderStatus.readyToIssue)
                                                Padding(
                                                  padding: getMarginOrPadding(bottom: 32),
                                                  child: Container(
                                                  
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(16.r),
                                                      color: UiConstants.blue2Color
                                                  
                                                    ),
                                                    child: Padding(
                                                      padding: getMarginOrPadding(all: 8),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: UiConstants.whiteColor.withOpacity(.8),
                                                              borderRadius: BorderRadius.circular(8.r)
                                                              
                                                            ),
                                                            child: Padding(padding: getMarginOrPadding(all: 8),
                                                              child: SvgPicture.asset(Paths.infoIconPath,colorFilter: ColorFilter.mode(
                                                                 UiConstants.blueColor, BlendMode.srcIn
                                                              ),),
                                                            ),
                                                          ),
                                                          SizedBox(width: 12.w,),
                                                          Expanded(child: Text(
                                                           orderState.order!.typeReceipt == TypeReceiving.pickup ?  'Заберите заказ в течение 48 часов или он будет отменен' : 'Заберите заказ в течение 7 дней или он будет отменен',
                                                          style: UiConstants.textStyle11.copyWith(
                                                            color: UiConstants.blueColor,
                                                            fontWeight: FontWeight.w500
                                                          ),))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                            (!orderState.isLoading &&
                                                    orderState.order!.status ==
                                                        OrderStatus.canceled)
                                                ? Container(
                                                    padding: EdgeInsets.zero,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              AppButtonWidget(
                                                            text:
                                                                'Связаться с нами',
                                                            showBorder: true,
                                                            textColor:
                                                                UiConstants
                                                                    .blueColor,
                                                            backgroundColor:
                                                                UiConstants
                                                                    .backgroundColor,
                                                            onTap: () {},
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8.w,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              AppButtonWidget(
                                                            text:
                                                                'Повторить заказ',
                                                            showBorder: true,
                                                            isFilled: true,
                                                            textColor:
                                                                UiConstants
                                                                    .white2Color,
                                                            backgroundColor:
                                                                UiConstants
                                                                    .blueColor,
                                                            onTap: () {},
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : 
                                                 AppButtonWidget(
                                                    isExpanded: false,
                                                    text: 'Связаться с нами',
                                                    showBorder: true,
                                                    textColor:
                                                        UiConstants.blueColor,
                                                    backgroundColor: UiConstants
                                                        .backgroundColor,
                                                    onTap: () {},
                                                  ),
                                            if (orderState.order?.status !=
                                                    OrderStatus.received &&
                                                orderState.order?.status !=
                                                    OrderStatus.canceled)
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 16.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                        child: Text(
                                                            'Отменить заказ'),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            Routes.createRoute(
                                                              const CancelOrderScreen(),
                                                              settings: RouteSettings(
                                                                  name: Routes
                                                                      .cancelOrderScreen,
                                                                  arguments:
                                                                      orderState
                                                                          .order
                                                                          ?.orderId),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 16.h,
                                                  )
                                                ],
                                              ),
                                            ProductsListWidget(
                                                products: orderState
                                                        .order?.products ??
                                                    [],
                                                productsListScreenType:
                                                    ProductsListScreenType
                                                        .order),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            OrderBuyInfoWidget(
                                                order: orderState.order),
                                            SizedBox(height: 32.h),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16.r),
                                                color: UiConstants.whiteColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xFF144B63)
                                                        .withOpacity(0.1),
                                                    blurRadius: 50,
                                                    spreadRadius: -4,
                                                    offset: Offset(-1, -4),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    getMarginOrPadding(all: 16),
                                                child: BlockWidget(
                                                  title: 'Информация о заказе',
                                                  spacing: 8,
                                                  child: OrderInfoList(
                                                      order: orderState.order),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 32.h),
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
