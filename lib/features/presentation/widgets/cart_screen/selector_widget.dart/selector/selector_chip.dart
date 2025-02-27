import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';

class SelectorChip extends StatelessWidget {
  final String text;
  final bool selected;
  final int index;
  final Function(int index) onTap;

  const SelectorChip(
      {required this.text,
      required this.selected,
      required this.index,
      super.key,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap(index);
          BlocProvider.of<SelectorCubit>(context).onSelectorItemTap(index);
        },
        child: Container(
          padding: getMarginOrPadding(top: 10, bottom: 10),
          alignment: Alignment.center,
          margin: getMarginOrPadding(left: index != 0 ? 2 : 0),
          decoration: BoxDecoration(
            color: selected ? UiConstants.purpleColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            text,
            style: UiConstants.textStyle2.copyWith(
                fontSize: 15.sp,
                color: selected
                    ? UiConstants.whiteColor
                    : UiConstants.darkBlueColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
