import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:intl/intl.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DateIconWidget extends StatelessWidget {
  const DateIconWidget({super.key, required this.date});

  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Skeleton.replace(
          child: SvgPicture.asset(Paths.calendarIconPath,
              width: 16.w, height: 16.w),
        ),
        SizedBox(width: 6.w),
        Text(
          date != null ? DateFormat('dd.MM.yyyy').format(date!) : '',
          style: UiConstants.textStyle3.copyWith(
            color: UiConstants.darkBlue2Color.withOpacity(.6),
          ),
        ),
      ],
    );
  }
}
