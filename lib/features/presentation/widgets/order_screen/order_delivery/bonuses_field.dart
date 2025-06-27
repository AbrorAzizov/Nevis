import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class BonusesField extends StatelessWidget {
  const BonusesField(
      {super.key, required this.onChangedField, required this.isEnabled});

  final bool isEnabled;
  final Function(String) onChangedField;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return TextFormField(
      enabled: isEnabled,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      controller: controller,
      style: UiConstants.textStyle11
          .copyWith(color: UiConstants.black3Color, height: 1),
      cursorColor: UiConstants.darkBlueColor,
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: UiConstants.defaultBorderColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(width: 3, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
              width: 3, color: UiConstants.blueColor.withOpacity(.6)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(width: 3, color: UiConstants.pinkColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(width: 3, color: UiConstants.pinkColor),
        ),
        filled: true,
        fillColor: UiConstants.whiteColor,
        hintText: 'Сколько?',
        contentPadding:
            getMarginOrPadding(left: 16, right: 16, top: 7, bottom: 7),
        hintStyle: UiConstants.textStyle11.copyWith(
            color: UiConstants.black3Color.withOpacity(.6), height: 1),
      ),
      textAlign: TextAlign.start,
      onChanged: onChangedField,
      onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
      onTapAlwaysCalled: true,
    );
  }
}
