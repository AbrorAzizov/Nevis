import 'package:flutter/material.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';

class DropdownBlockItem extends StatelessWidget {
  const DropdownBlockItem({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onChanged,
  });

  final String text;
  final bool isChecked;
  final Function(bool? isChecked) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCheckbox(
            isChecked: isChecked,
            title: Text(
              text,
              style: UiConstants.textStyle8
                  .copyWith(color: UiConstants.blackColor),
            ),
            onChanged: onChanged),
      ],
    );
  }
}
