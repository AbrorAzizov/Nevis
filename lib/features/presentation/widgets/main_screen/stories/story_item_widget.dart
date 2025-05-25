import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';

class StoryItemWidget extends StatelessWidget {
  const StoryItemWidget({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64.w,
        decoration: BoxDecoration(
            color: UiConstants.blue4Color,
            border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFBF80FF),
                    Color(0xFF85C6FF),
                  ],
                ),
                width: 2),
            shape: BoxShape.circle),
        child: Image.asset(Paths.mockStoryPath),
      ),
    );
  }
}
