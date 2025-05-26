import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/pages/profile/sales/sale_screen.dart';
import 'package:nevis/features/presentation/widgets/sales_screen/sales_list_item.dart';

class SalesHorizontalListWidget extends StatelessWidget {
  const SalesHorizontalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xFF144B63).withOpacity(0.1),
          blurRadius: 50,
          spreadRadius: -4,
          offset: Offset(-1, -4),
        ),
      ]),
      height: 206.w,
      child: ListView.separated(
          padding: getMarginOrPadding(left: 20, right: 20),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SalesListItem(
                hasShadow: false,
                onTap: () => Navigator.of(context).push(
                  Routes.createRoute(
                    SaleScreen(),
                    settings: RouteSettings(name: Routes.saleScreen),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(width: 8.w),
          itemCount: 10),
    );
  }
}
