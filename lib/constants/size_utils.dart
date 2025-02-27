import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

EdgeInsets getMarginOrPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  if (all != null) {
    left = all.w;
    top = all.w;
    right = all.w;
    bottom = all.w;
    return EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }
  return EdgeInsets.only(
    left: left?.w ?? 0,
    top: top?.h ?? 0,
    right: right?.w ?? 0,
    bottom: bottom?.h ?? 0,
  );
}
