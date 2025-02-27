import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class SearchHistoryItem extends StatelessWidget {
  const SearchHistoryItem(
      {super.key, required this.title, this.onTapDelete, required this.onTap});

  final String title;
  final Function()? onTapDelete;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: getMarginOrPadding(left: 16, right: 16, top: 9, bottom: 9),
        decoration: BoxDecoration(
            color: UiConstants.white2Color,
            borderRadius: BorderRadiusDirectional.circular(8.r)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: UiConstants.textStyle2
                  .copyWith(color: UiConstants.darkBlueColor),
            ),
            if (onTapDelete != null)
              Padding(
                padding: getMarginOrPadding(left: 4),
                child: GestureDetector(
                  onTap: onTapDelete,
                  child: SvgPicture.asset(Paths.close2IconPath,
                      height: 16.w, width: 16.w),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
