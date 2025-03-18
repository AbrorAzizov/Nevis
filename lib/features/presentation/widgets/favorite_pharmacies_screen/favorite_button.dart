import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';

class FavoriteButton extends StatelessWidget {
  final Function() onPressed;

  const FavoriteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.w,
      width: 24.w,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.favorite, color: UiConstants.blueColor, size: 16.w),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: UiConstants.blue4Color,
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
