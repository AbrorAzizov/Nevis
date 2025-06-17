import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/models/recommended_item_model.dart';
import 'package:nevis/features/presentation/widgets/main_screen/recommended/recommended_item_widget.dart';

class RecommendedListWidget extends StatelessWidget {
  const RecommendedListWidget({super.key, required this.items});

  final List<RecommendedItemModel> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.w,
      child: ListView.separated(
          padding: getMarginOrPadding(left: 20, right: 20),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => RecommendedItemWidget(
                item: items[index],
              ),
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemCount: items.length),
    );
  }
}
