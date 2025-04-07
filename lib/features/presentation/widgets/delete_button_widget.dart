import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';

class DeleteButton extends StatelessWidget {
  final Function() onPressed;

  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.h,
      width: 24.w,
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          Paths.deleteIconPath,
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
