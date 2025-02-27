import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:skeletonizer/skeletonizer.dart';

class AppTextFieldWidget extends StatefulWidget {
  const AppTextFieldWidget({
    super.key,
    this.hintText,
    required this.controller,
    this.suffixWidget,
    this.suffixIcon,
    this.contentPadding,
    this.keyboardType = TextInputType.text,
    this.isObscuredText = false,
    this.isNeedShowHiddenTextIcon = false,
    this.prefixWidget,
    this.onTap,
    this.readOnly = false,
    this.suffixText,
    this.isNeedLabel = false,
    this.isExpanded = false,
    this.minLines = 1,
    this.validator,
    this.textInputAction,
    this.errorText,
    this.regExp,
    this.isTextFieldInBottomSheet = false,
    this.isEnabled = true,
    this.inputFormatters,
    this.textStyle,
    this.maxLength,
    this.isShowError = true,
    this.onChangedField,
    this.title,
    this.description,
    this.fillColor,
    this.actionTitle,
    this.onTapActionTitle,
    this.boxShadow,
    this.focusNode,
    this.onTapOutside,
    this.hintMaxLines,
    this.suffixPadding,
    this.isActionTitleActive = true,
  });

  final String? hintText;
  final TextEditingController controller;
  final Widget? suffixWidget;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final EdgeInsets? contentPadding;
  final TextInputType keyboardType;
  final bool isObscuredText;
  final bool isNeedShowHiddenTextIcon;
  final Function? onTap;
  final bool readOnly;
  final bool isEnabled;
  final String? suffixText;
  final bool isNeedLabel;
  final bool isExpanded;
  final int minLines;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final String? errorText;
  final RegExp? regExp;
  final bool isTextFieldInBottomSheet;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? textStyle;
  final int? maxLength;
  final bool isShowError;
  final Function(String)? onChangedField;
  final Function(PointerDownEvent event)? onTapOutside;
  final String? title;
  final String? description;
  final String? actionTitle;
  final Function()? onTapActionTitle;
  final Color? fillColor;
  final List<BoxShadow>? boxShadow;
  final FocusNode? focusNode;
  final int? hintMaxLines;
  final EdgeInsets? suffixPadding;
  final bool isActionTitleActive;

  @override
  State<AppTextFieldWidget> createState() => _GidTextFieldState();
}

class _GidTextFieldState extends State<AppTextFieldWidget> {
  bool isShowPassword = false;

  @override
  void initState() {
    isShowPassword = widget.isObscuredText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null || widget.actionTitle != null)
          Padding(
            padding: getMarginOrPadding(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.title != null)
                  Text(
                    widget.title ?? '',
                    style: UiConstants.textStyle2
                        .copyWith(color: UiConstants.darkBlueColor),
                  ),
                if (widget.actionTitle != null)
                  GestureDetector(
                    onTap: widget.isActionTitleActive
                        ? widget.onTapActionTitle
                        : null,
                    child: Text(
                      widget.actionTitle ?? '',
                      style: UiConstants.textStyle2.copyWith(
                          color: widget.isActionTitleActive
                              ? UiConstants.purpleColor
                              : UiConstants.oliveGreenColor),
                    ),
                  ),
              ],
            ),
          ),
        Container(
          height: widget.isExpanded ? 44.h : null,
          decoration: BoxDecoration(boxShadow: widget.boxShadow),
          child: TextFormField(
            focusNode: widget.focusNode,
            autofocus: false,
            textInputAction: widget.textInputAction,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            enabled: widget.isEnabled,
            expands: widget.isExpanded,
            maxLines: widget.isExpanded ? null : widget.minLines,
            onTap: () => widget.onTap != null ? widget.onTap!() : null,
            readOnly: widget.readOnly,
            obscureText: isShowPassword,
            obscuringCharacter: '•',
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            style: (widget.textStyle ?? UiConstants.textStyle3).copyWith(
                decorationThickness: 0,
                height: 1,
                color: UiConstants.darkBlueColor),
            cursorColor: UiConstants.darkBlueColor,
            decoration: InputDecoration(
              hintMaxLines: widget.hintMaxLines ?? 500,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide:
                    const BorderSide(width: 3, color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                    width: 3, color: UiConstants.purple2Color.withOpacity(.2)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide:
                    const BorderSide(width: 3, color: UiConstants.pinkColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide:
                    const BorderSide(width: 3, color: UiConstants.pinkColor),
              ),
              filled: true,
              fillColor: widget.fillColor ?? UiConstants.white3Color,
              hintText: widget.hintText,
              contentPadding: widget.contentPadding ??
                  getMarginOrPadding(left: 16, right: 16, top: 10, bottom: 10),
              hintStyle: (widget.textStyle ?? UiConstants.textStyle3).copyWith(
                  color: UiConstants.darkBlue2Color.withOpacity(.6), height: 1),
              suffixIcon: Skeleton.ignore(
                child: InkWell(
                  onTap: widget.isObscuredText
                      ? () => setState(
                            () => isShowPassword = !isShowPassword,
                          )
                      : null,
                  child: SizedBox(
                    child: widget.isObscuredText
                        ? Padding(
                            padding: getMarginOrPadding(top: 10, bottom: 10),
                            child: SvgPicture.asset(
                              isShowPassword
                                  ? Paths.visibilityOffIconPath
                                  : Paths.visibilityOnIconPath,
                              color: UiConstants.darkBlueColor.withOpacity(.4),
                            ),
                          )
                        : widget.suffixWidget != null
                            ? Padding(
                                padding: widget.suffixPadding ??
                                    getMarginOrPadding(left: 16, right: 16),
                                child: widget.suffixWidget)
                            : null,
                  ),
                ),
              ),
              suffixText:
                  widget.controller.text.isNotEmpty ? widget.suffixText : null,
              prefixIcon: widget.prefixWidget != null
                  ? Padding(
                      padding: getMarginOrPadding(left: 16, right: 12),
                      child: widget.prefixWidget)
                  : null,
              prefixIconConstraints: BoxConstraints(maxWidth: 52.w),
              errorText: widget.isShowError ? widget.errorText : null,
              errorStyle: (widget.textStyle ?? UiConstants.textStyle10)
                  .copyWith(
                      color: UiConstants.redColor,
                      height: 0,
                      fontWeight: FontWeight.w400),
            ),
            textAlign: TextAlign.start,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: widget.onChangedField,
            onTapOutside: (event) =>
                widget.onTapOutside ??
                FocusScope.of(context).requestFocus(FocusNode()),
          ),
        ),
        if (widget.description != null)
          Padding(
            padding: getMarginOrPadding(top: 2),
            child: Text(
              widget.description ?? '',
              style: UiConstants.textStyle10
                  .copyWith(color: UiConstants.darkBlueColor),
            ),
          ),
      ],
    );
  }
}
