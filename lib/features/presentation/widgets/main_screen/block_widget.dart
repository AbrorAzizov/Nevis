import 'package:flutter/material.dart';
import 'package:nevis/constants/ui_constants.dart';

class BlockWidget extends StatefulWidget {
  const BlockWidget({
    super.key,
    required this.title,
    this.clickableText,
    this.onTap,
    this.child,
    this.contentPadding,
    this.titleStyle,
    this.spacing,
  });

  final String title;
  final String? clickableText;
  final Function()? onTap;
  final Widget? child;
  final EdgeInsets? contentPadding;
  final TextStyle? titleStyle;
  final double? spacing;

  @override
  _BlockWidgetState createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    // Начинаем с раскрытого состояния
    _controller.value = 1.0;
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: widget.contentPadding ?? EdgeInsets.zero,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _toggleExpand,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: (widget.titleStyle ?? UiConstants.textStyle5)
                            .copyWith(color: UiConstants.darkBlueColor),
                      ),
                      const SizedBox(width: 8), // Отступ перед иконкой
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return RotationTransition(
                              turns: animation, child: child);
                        },
                        child: Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          key: ValueKey(_isExpanded),
                          color: UiConstants.darkBlueColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.clickableText != null)
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    widget.clickableText!,
                    style: UiConstants.textStyle3.copyWith(
                      color: UiConstants.darkBlue2Color.withOpacity(.6),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: _animation,
          axisAlignment: -1.0,
          child: widget.child ?? const SizedBox(),
        ),
      ],
    );
  }
}
