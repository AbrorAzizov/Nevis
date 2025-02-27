import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:pinput/pinput.dart';

class PinputWidget extends StatefulWidget {
  const PinputWidget(
      {super.key,
      this.showError = false,
      required this.controller,
      required this.focusNode});

  final bool showError;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  _PinputWidgetState createState() => _PinputWidgetState();
}

class _PinputWidgetState extends State<PinputWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 64.w,
      textStyle: UiConstants.textStyle4.copyWith(
        color:
            widget.showError ? UiConstants.redColor : UiConstants.darkBlueColor,
      ),
      decoration: BoxDecoration(
        color: UiConstants.white2Color,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 3, color: Colors.transparent),
      ),
    );

    return SizedBox(
      child: Pinput(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        separatorBuilder: (index) => SizedBox(width: 8.w),
        forceErrorState: widget.showError,
        length: 4,
        controller: widget.controller,
        focusNode: widget.focusNode,
        defaultPinTheme: defaultPinTheme,
        onChanged: (pin) {
          //if (showErrorState && pin.isNotEmpty) {
          //  setState(() {
          //    showErrorState = false;
          //  });
          //}
        },
        onCompleted: (pin) {
          widget.focusNode.unfocus();
          //if (pin != "5555") {
          //  setState(() {
          //    showErrorState = true;
          //  });
          //}
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 68.h,
          width: 60.h,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: UiConstants.purple2Color.withOpacity(.2)),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(
              width: 3,
              color: widget.controller.text.isNotEmpty
                  ? UiConstants.purple2Color.withOpacity(.2)
                  : Colors.transparent,
            ),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(
              width: 3,
              color: UiConstants.redColor.withOpacity(.5),
            ),
          ),
        ),
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(FocusNode()),
      ),
    );
  }
}
