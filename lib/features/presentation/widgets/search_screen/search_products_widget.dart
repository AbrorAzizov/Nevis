import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/search_screen/search_products_item.dart';

class SearchProductsWidget extends StatelessWidget {
  const SearchProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlockWidget(
      title: 'Товары',
      child: Container(
        padding: getMarginOrPadding(all: 8),
        decoration: BoxDecoration(
            color: UiConstants.whiteColor,
            borderRadius: BorderRadiusDirectional.circular(16.r)),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => SearchProductsItem(),
            separatorBuilder: (context, index) => Container(
                  padding: getMarginOrPadding(top: 8, bottom: 8),
                  height: 18.h,
                  child:
                      Divider(color: UiConstants.white5Color, thickness: 2.h),
                ),
            itemCount: 8),
      ),
    );
  }
}
