import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapButton extends StatelessWidget {
  final String assetName;
  final Color color;
  final Color backgroundColor;
  final Function() onPressed;

  const MapButton(
      {super.key,
      required this.assetName,
      required this.color,
      required this.backgroundColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon:
          SvgPicture.asset(assetName, width: 16.w, height: 16.w, color: color),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
        backgroundColor: backgroundColor,
        fixedSize: Size(36.w, 36.w),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r), side: BorderSide.none),
      ),
    );
  }
}
