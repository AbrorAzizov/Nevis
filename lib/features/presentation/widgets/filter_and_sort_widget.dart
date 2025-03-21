import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_radio_button.dart';
import 'package:nevis/features/presentation/widgets/dropdown_block_item.dart';
import 'package:nevis/features/presentation/widgets/dropdown_block_template.dart';
import 'package:nevis/features/presentation/widgets/products_screen/sort_widget.dart';
import 'package:nevis/features/presentation/widgets/search_screen/price_range_widget.dart';

class FilterSortContainer extends StatelessWidget {
  final List<ProductSortType> sortTypes;
  final ProductSortType? selectedSortType;
  final Function(ProductSortType) onSortSelected;
  final ProductFilterOrSortType? filterOrSortType;

  const FilterSortContainer({
    Key? key,
    required this.sortTypes,
    required this.selectedSortType,
    required this.onSortSelected,
    required this.filterOrSortType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: filterOrSortType != null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: UiConstants.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF144B63).withOpacity(0.1),
                  blurRadius: 50,
                  spreadRadius: -4,
                  offset: const Offset(-1, -4),
                ),
              ],
            )
          : null,
      child: Padding(
        padding: getMarginOrPadding(top: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SortWidget(
                    iconColor:
                        filterOrSortType == ProductFilterOrSortType.filter
                            ? UiConstants.blueColor
                            : UiConstants.black3Color.withOpacity(.6),
                    style: filterOrSortType == ProductFilterOrSortType.filter
                        ? UiConstants.textStyle11
                            .copyWith(color: UiConstants.blueColor): UiConstants.textStyle11,
                    text: 'Фильтр',
                    iconPath: Paths.sortIconPath,
                    onTap: () {
                       context
                          .read<FavoriteProductsScreenBloc>()
                          .add(ShowFilterProductsTypes());
                    },
                  ),
                ),
                Expanded(
                  child: SortWidget(
                    iconColor: filterOrSortType == ProductFilterOrSortType.sort
                        ? UiConstants.blueColor
                        : UiConstants.black3Color.withOpacity(.6),
                    style: filterOrSortType == ProductFilterOrSortType.sort
                        ? UiConstants.textStyle11
                            .copyWith(color: UiConstants.blueColor)
                        : UiConstants.textStyle11,
                    text: 'Сортировка',
                    iconPath: Paths.filtersIconPath,
                    onTap: () {
                      context
                          .read<FavoriteProductsScreenBloc>()
                          .add(ShowSortProductsTypes());
                    },
                  ), 
                ),
              ],
            ),
            if (filterOrSortType == ProductFilterOrSortType.sort)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    sortTypes.length,
                    (index) {
                      final productSortType = sortTypes[index];
                      return CustomRadioButton(
                        isLabelOnLeft: false,
                        title: productSortType.displayName,
                        textStyle: UiConstants.textStyle2,
                        value: productSortType,
                        groupValue: selectedSortType,
                        onChanged: (value) => onSortSelected(productSortType),
                      );
                    },
                  ),
                ),
              ),
               if (filterOrSortType == ProductFilterOrSortType.filter)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 500,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Фильтры',
                            style: UiConstants.textStyle5
                                .copyWith(color: UiConstants.darkBlueColor),
                          ),
                         
                        ],
                      ),
                      SizedBox(height: 16.h),
                      PriceRangeWidget(),
                      SizedBox(height: 11.h),
                      DropdownBlockTemplate(
                        title: 'Форма выпуска',
                        child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => DropdownBlockItem(
                                  text: 'Text',
                                  isChecked: true,
                                      
                                  onChanged: (isChecked) {
                
                                  }
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 8),
                            itemCount: 5),
                      ),
                      SizedBox(height: 16.h),
                      DropdownBlockTemplate(
                        title: 'Страна производства',
                        child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => DropdownBlockItem(
                                  text: 'Text',
                                  isChecked: true,
                                  onChanged: (isChecked){
                
                                  }
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 8),
                            itemCount: 5),
                      ),
                      Padding(
                        padding: getMarginOrPadding(top: 16, bottom: 16),
                        child: Divider(
                          color: UiConstants.white5Color,
                        ),
                      ),
                      DropdownBlockItem(
                        text: 'Без рецепта',
                        isChecked: true,
                        onChanged: (isChecked) {
                
                        }
                      ),
                      SizedBox(height: 8.h),
                      DropdownBlockItem(
                        text: 'Участвует в акции',
                        isChecked:  true,
                        onChanged: (isChecked) {
                
                        }
                      ),
                      SizedBox(height: 8.h),
                      DropdownBlockItem(
                        text: 'Возможна доставка',
                        isChecked:true,
                        onChanged: (isChecked) {
                          
                        }
                      ),
                      SizedBox(height: 16.h),
                      AppButtonWidget(
                        text: 'Показать результаты',
                        onTap: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
