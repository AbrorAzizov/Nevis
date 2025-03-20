import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.controller,
    this.showLocationChip = false,
    this.showBack = false,
    this.title,
    this.action,
    this.contentPadding,
    this.backgroundColor,
    this.hintText,
    this.isShowFavoriteButton = false,
    this.onChangedField,
    this.onTapField,
    this.screenContext,
    this.onTapCancel,
  });

  final BuildContext? screenContext;
  final TextEditingController? controller;
  final bool showLocationChip;
  final bool showBack;
  final String? title;
  final Widget? action;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final String? hintText;
  final bool isShowFavoriteButton;
  final Function(String value)? onChangedField;
  final Function()? onTapField;
  final Function()? onTapCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? UiConstants.whiteColor,
      padding: contentPadding ??
          getMarginOrPadding(top: 16, bottom: 8, right: 20, left: 20),
      child: Column(
        children: [
          if (title != null || action != null || controller == null)
            Padding(
              padding: getMarginOrPadding(bottom: controller != null ? 16 : 0),
              child: Row(
                children: [
                  if (showBack)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(Paths.arrowBackIconPath,
                          color: UiConstants.black3Color.withOpacity(.6),
                          width: 24.w,
                          height: 24.w),
                    ),
                  Expanded(
                    child: Skeleton.keep(
                      child: Center(
                        child: Text(title ?? '',
                            style: showBack
                                ? UiConstants.textStyle5
                                : UiConstants.textStyle1
                                    .copyWith(color: UiConstants.darkBlueColor),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  Skeleton.ignore(child: action ?? Container())
                ],
              ),
            ),
          if (controller != null)
            Row(
              children: [
                if (showLocationChip)
                  Skeleton.replace(
                    child: Padding(
                      padding: getMarginOrPadding(right: 8),
                      child: SvgPicture.asset(Paths.locationIconPath,
                          width: 24.w, height: 24.w),
                    ),
                  ),
                if (showBack && title == null && action == null)
                  Padding(
                    padding: getMarginOrPadding(right: 10),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(Paths.arrowBackIconPath,
                          color: UiConstants.darkBlue2Color.withOpacity(.6),
                          width: 24.w,
                          height: 24.w),
                    ),
                  ),
                Expanded(
                  child: Skeleton.ignorePointer(
                    child: Skeleton.shade(
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundColor ?? UiConstants.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF144B63).withOpacity(0.1),
                              blurRadius: 50,
                              spreadRadius: -4,
                              offset: Offset(-1, -4),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF144B63).withOpacity(0.01),
                                blurRadius: 50,
                                spreadRadius: -4,
                                offset: Offset(-1, -4),
                              ),
                            ],
                          ),
                          child: AppTextFieldWidget(
                              hintText: hintText ?? 'Поиск товаров',
                              fillColor: UiConstants.whiteColor,
                              controller: controller ?? TextEditingController(),
                              prefixWidget: Skeleton.ignore(
                                child: SvgPicture.asset(Paths.searchIconPath),
                              ),
                              suffixWidget: controller!.text.isNotEmpty
                                  ? Skeleton.ignore(
                                      child: GestureDetector(
                                        onTap: onTapCancel,
                                        child: SvgPicture.asset(
                                          Paths.closeIconPath,
                                          colorFilter: ColorFilter.mode(
                                              UiConstants.blackColor,
                                              BlendMode.srcIn),
                                        ),
                                      ),
                                    )
                                  : null,
                              onChangedField: onChangedField,
                              onTap: onTapField),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
