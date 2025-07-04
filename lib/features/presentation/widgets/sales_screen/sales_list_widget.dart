import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';
import 'package:nevis/features/presentation/pages/profile/sales/sale_screen.dart';
import 'package:nevis/features/presentation/widgets/sales_screen/sales_list_item.dart';

class SalesListWidget extends StatefulWidget {
  const SalesListWidget({super.key, required this.promotions, this.scrollController});
  final List<PromotionEntity> promotions;
  final ScrollController? scrollController;

  @override
  State<SalesListWidget> createState() => _SalesListWidgetState();
}

class _SalesListWidgetState extends State<SalesListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: widget.scrollController,
        // shrinkWrap: true,
        padding: getMarginOrPadding(bottom: 90, top: 16, left: 20, right: 20),
        itemBuilder: (context, index) => SalesListItem(
              onTap: () => Navigator.of(context).push(
                Routes.createRoute(
                  SaleScreen(promoId: widget.promotions[index].id,),
                  settings: RouteSettings(name: Routes.saleScreen),
                ),
              ), promotion: widget.promotions[index],
            ),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemCount: widget.promotions.length);
  }
}
