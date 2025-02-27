import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class PinkContainerWidget extends StatelessWidget {
  const PinkContainerWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: Container(
        width: double.infinity,
        padding: getMarginOrPadding(all: 12),
        decoration: BoxDecoration(
          color: UiConstants.pink2Color.withOpacity(.05),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(children: children),
      ),
    );
  }
}
