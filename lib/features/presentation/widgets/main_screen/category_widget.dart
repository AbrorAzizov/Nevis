import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';


class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key, required this.imagePath, required this.title});

  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(top: 16, bottom: 8, right: 8, left: 8),
      decoration: BoxDecoration(
        color: UiConstants.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // SvgPicture.network('${dotenv.env['PUBLIC_URL']!}$imagePath',
          //     width: 40.w, height: 40.w),
          SizedBox(height: 12.h),
          Text(title,
              style: UiConstants.textStyle3
                  .copyWith(color: UiConstants.darkBlueColor),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
