import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/sales_screen/sales_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/chip_with_text_widget.dart';

class SalesCategoriesList extends StatelessWidget {
  const SalesCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesScreenBloc, SalesScreenState>(
      builder: (context, state) {
        SalesScreenBloc salesBloc = context.read<SalesScreenBloc>();
        List<String> categories = state.categories;
        return SizedBox(
          height: 32.h,
          child: ListView.separated(
              padding: getMarginOrPadding(left: 20, right: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String currentCategory = categories[index];
                return ChipWithTextWidget(
                  title: currentCategory,
                  textStyle: UiConstants.textStyle8,
                  onTap: () => salesBloc.add(
                    ChangeCategoryEvent(index),
                  ),
                  textColor:
                      currentCategory == categories[state.currentCategoryIndex]
                          ? UiConstants.whiteColor
                          : UiConstants.darkBlue2Color,
                  backgroundColor:
                      currentCategory == categories[state.currentCategoryIndex]
                          ? UiConstants.purpleColor
                          : UiConstants.whiteColor,
                  padding: getMarginOrPadding(
                      top: 8, bottom: 8, right: 16, left: 16),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 4.w),
              itemCount: categories.length),
        );
      },
    );
  }
}
