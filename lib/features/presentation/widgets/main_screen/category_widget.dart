import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key, required this.imagePath, required this.title});

  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              color: UiConstants.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: const Color(0x1A00A0E3),
                  offset: const Offset(-1, 4),
                  blurRadius: 10,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: Padding(
              padding: getMarginOrPadding(all: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: UiConstants.blue5Color.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                    padding: getMarginOrPadding(all: 5),
                    child: SizedBox(
                      width: 50.w,
                      height: 50.w,
                      child: SvgPicture.network(
                        imagePath,
                        fit: BoxFit.contain, // Вписывает содержимое в рамки
                        colorFilter: ColorFilter.mode(
                            UiConstants.blueColor, BlendMode.srcIn),
                        placeholderBuilder: (context) =>
                            const CircularProgressIndicator(
                          color: UiConstants.blueColor,
                        ),
                      ),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(title,
              style: UiConstants.textStyle8
                  .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
