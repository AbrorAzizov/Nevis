import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class DropdownBlockTemplate extends StatefulWidget {
  const DropdownBlockTemplate({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  State<DropdownBlockTemplate> createState() => _DropdownBlockTemplateState();
}

class _DropdownBlockTemplateState extends State<DropdownBlockTemplate>
    with SingleTickerProviderStateMixin {
  bool isVisible = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    if (isVisible) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
      if (isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleVisibility,
          child: Row(
            children: [
              Text(
                widget.title,
                style: UiConstants.textStyle3.copyWith(
                  color: UiConstants.darkBlueColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 4.w),
              AnimatedRotation(
                turns: isVisible ? 0.0 : 0.5,
                duration: const Duration(milliseconds: 300),
                child: SvgPicture.asset(
                  Paths.dropdownArrowIconPath,
                  width: 24.w,
                  height: 24.w,
                ),
              ),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: _animation,
          axisAlignment: -1.0, // начало анимации сверху
          child: Padding(
            padding: getMarginOrPadding(top: 8),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
