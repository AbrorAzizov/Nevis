import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector_chip.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Selector extends StatefulWidget {
  const Selector({super.key, required this.titlesList, required this.onTap});

  final List<String> titlesList;
  final Function(int index) onTap;

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: Container(
        decoration: BoxDecoration(
          color: UiConstants.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF144B63).withOpacity(0.1),
              blurRadius: 50,
              spreadRadius: -4,
              offset: Offset(-1, -4),
            ),
          ],
        ),
        padding: getMarginOrPadding(left: 4, right: 4),
        child: BlocBuilder<SelectorCubit, SelectorState>(
          builder: (context, state) {
            return Row(
              children: List.generate(
                widget.titlesList.length,
                (index) => SelectorChip(
                    text: widget.titlesList[index],
                    selected: state.selectedIndex == index,
                    index: index,
                    onTap: widget.onTap),
              ),
            );
          },
        ),
      ),
    );
  }
}
