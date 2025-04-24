import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';

class FavoriteButton extends StatelessWidget {
  final bool? isFav;
  final VoidCallback onPressed;

  const FavoriteButton({
    super.key,
    this.isFav,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.w,
      width: 24.w,
      child: IconButton(
        onPressed: onPressed,
        icon: isFav ?? false
            ? SvgPicture.asset(
                Paths.isFav,
                width: 13.w,
                height: 13.h,
              )
            : SvgPicture.asset(
                Paths.notFav,
                width: 13.w,
                height: 13.h,
              ),
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: const Color(0xFF222222).withOpacity(.05),
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}
