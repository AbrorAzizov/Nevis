import 'package:flutter/material.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar/search_product_app_bar.dart';

class OrderPickupSuccessScreen extends StatelessWidget {
  const OrderPickupSuccessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final List<OrderEntity> orders = args?['orders'];

    return Scaffold(
      backgroundColor: UiConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SearchProductAppBar(
              showFavoriteProductsChip: true,
              showLocationChip: true,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: getMarginOrPadding(
                  bottom: 94,
                  right: 20,
                  left: 20,
                  top: 16,
                ),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(orders.length, (index) {
                      return OrderWidget(order: orders[index]);
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
