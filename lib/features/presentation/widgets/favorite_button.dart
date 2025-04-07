import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';

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
        icon: SvgPicture.asset(
          Paths.favouriteProductsIconPath,
          width: 13.w,
          height: 13.h,
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: Color(0xFF222222).withOpacity(.05),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
