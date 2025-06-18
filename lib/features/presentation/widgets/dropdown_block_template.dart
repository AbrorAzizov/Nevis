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
    with AutomaticKeepAliveClientMixin {
  bool isVisible = true;

  void _toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isVisible
              ? RepaintBoundary(
                  child: Padding(
                    padding: getMarginOrPadding(top: 8),
                    child: widget.child,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
