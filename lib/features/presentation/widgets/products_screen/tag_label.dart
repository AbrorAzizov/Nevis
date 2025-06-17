import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagLabel extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  const TagLabel({
    super.key,
    required this.text,
    required this.textStyle,
    this.backgroundColor,
    this.backgroundGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: backgroundGradient == null ? backgroundColor : null,
        gradient: backgroundGradient,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
