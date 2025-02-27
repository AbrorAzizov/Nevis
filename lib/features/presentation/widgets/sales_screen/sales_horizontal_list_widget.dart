import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/features/presentation/widgets/sales_screen/sales_list_item.dart';

class SalesHorizontalListWidget extends StatelessWidget {
  const SalesHorizontalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235.w,
      child: ListView.separated(
          padding: getMarginOrPadding(left: 20, right: 20),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => SalesListItem(),
          separatorBuilder: (context, index) => SizedBox(width: 8.w),
          itemCount: 10),
    );
  }
}
