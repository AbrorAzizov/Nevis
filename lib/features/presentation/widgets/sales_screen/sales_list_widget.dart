import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/pages/profile/sales/sale_screen.dart';
import 'package:nevis/features/presentation/widgets/sales_screen/sales_list_item.dart';

class SalesListWidget extends StatelessWidget {
  const SalesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: getMarginOrPadding(bottom: 90, top: 16, left: 20, right: 20),
        itemBuilder: (context, index) => SalesListItem(
              onTap: () => Navigator.of(context).push(
                Routes.createRoute(
                  SaleScreen(),
                  settings: RouteSettings(name: Routes.saleScreen),
                ),
              ),
            ),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemCount: 10);
  }
}
