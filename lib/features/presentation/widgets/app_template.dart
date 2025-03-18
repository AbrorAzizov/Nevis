import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class AppTemplate extends StatelessWidget {
  const AppTemplate(
      {super.key,
      required this.title,
      this.subTitleText,
      this.subTitleWidget,
      required this.body,
      this.canBack = false,
      this.bodyPadding,
      this.heightOfTopBar = 231});

  final String title;
  final String? subTitleText;
  final Widget? subTitleWidget;
  final Widget body;
  final bool canBack;
  final EdgeInsetsGeometry? bodyPadding;
  final int heightOfTopBar;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Paths.backgroundGradientIconPath),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                padding: getMarginOrPadding(
                    left: 20, right: 20, top: kTextTabBarHeight, bottom: 16),
                height: heightOfTopBar.h,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (canBack)
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios,
                            size: 15.w, color: UiConstants.whiteColor),
                      ),
                    Spacer(),
                    Text(
                      title,
                      style: UiConstants.textStyle1.copyWith(
                          color: UiConstants.whiteColor,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w600,
                          fontSize: 32.sp),
                    ),
                    if (subTitleText != null)
                      Padding(
                        padding: getMarginOrPadding(top: 16),
                        child: Text(
                          subTitleText ?? '',
                          style: UiConstants.textStyle2
                              .copyWith(color: UiConstants.whiteColor)
                              .copyWith(
                                fontSize: 16.sp,
                                letterSpacing: 0,
                              ),
                        ),
                      )
                    else if (subTitleWidget != null)
                      Padding(
                        padding: getMarginOrPadding(bottom: 8),
                        child: subTitleWidget ?? Container(),
                      )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    width: double.infinity,
                    padding: bodyPadding ??
                        getMarginOrPadding(top: 32, right: 20, left: 20),
                    decoration: BoxDecoration(
                      color: UiConstants.whiteColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.r),
                      ),
                    ),
                    child: body),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
