import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/products_screen/sort_button.dart';

import 'package:skeletonizer/skeletonizer.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignorePointer(
      child: Skeleton.leaf(
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                padding:
                    getMarginOrPadding(left: 8, top: 8, bottom: 8, right: 16),
                decoration: BoxDecoration(
                  color: UiConstants.whiteColor,
                  borderRadius: BorderRadius.circular(200.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SortButton(onTap: onTap),
                    SizedBox(width: 8.w),
                    Text(
                      'Сортировка',
                      style: UiConstants.textStyle3
                          .copyWith(color: UiConstants.darkBlueColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
