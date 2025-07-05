import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/data/models/delivery_order_model.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/order_delivery_success_screen/order_delivery_success_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/favourite_products_screen/selected_products_price_info_widget.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_delivery/order_delivery_bonuses.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_delivery/order_delivery_payment_methods.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_delivery/order_delivery_product_list.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar/search_product_app_bar.dart';

class OrderDeliverySuccessScreen extends StatelessWidget {
  const OrderDeliverySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final DeliveryOrderModel order = args?['order'];

    // Показываем только первые 2 товара, остальные скрываем под "Ещё (N)"
    final List<ProductEntity> items = order.items;

    return BlocProvider(
      create: (context) => OrderDeliverySuccessBloc(),
      child: BlocBuilder<OrderDeliverySuccessBloc, OrderDeliverySuccessState>(
        builder: (context, state) {
          final bloc = context.read<OrderDeliverySuccessBloc>();
          return Scaffold(
            backgroundColor: UiConstants.backgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  SearchProductAppBar(showFavoriteProductsChip: true),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      padding: getMarginOrPadding(
                          bottom: 94, right: 20, left: 20, top: 16),
                      children: [
                        Text(
                          'Ваш заказ\n№${order.orderId}',
                          style: UiConstants.textStyle17
                              .copyWith(color: UiConstants.black3Color),
                        ),
                        SizedBox(height: 24.h),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF144B63).withOpacity(0.1),
                                blurRadius: 50,
                                spreadRadius: -4,
                                offset: Offset(-1, -4),
                              ),
                            ],
                          ),
                          padding: getMarginOrPadding(all: 16),
                          child: OrderDeliveryProductList(items: items),
                        ),
                        SizedBox(height: 16.h),
                        SelectedProductsPriceInformationWidget(
                            price: order.sum,
                            totalPrice: order.sumWithDelivery,
                            totalDiscounts: order.economy,
                            deliveryPrice: order.deliveryPrice,
                            totalBonuses: order.bonuses.toInt(),
                            productsTotalCount: order.items.length),
                        SizedBox(height: 16.h),
                        OrderDeliveryPaymentMethods(
                          paymentMethod: state.paymentMethod,
                          changeMethod: (method) => bloc.add(
                            ChangePaymentMethodEvent(method),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        OrderDeliveryBonuses(
                          bonuses: order.bonuses.toInt(),
                          isChecked: state.bonusesChecked,
                          onCheckboxChanged: (value) => bloc.add(
                            ToggleBonusesCheckboxEvent(value ?? false),
                          ),
                          onBonusesChanged: (value) {},
                        ),
                        SizedBox(height: 16.h),
                        AppButtonWidget(
                          text: 'Оплатить заказ',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
