import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/products_screen/products_screen_bloc.dart' as prod;
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_radio_button.dart';
import 'package:nevis/features/presentation/widgets/dropdown_block_item.dart';
import 'package:nevis/features/presentation/widgets/dropdown_block_template.dart';
import 'package:nevis/features/presentation/widgets/products_screen/sort_widget.dart';
import 'package:nevis/features/presentation/widgets/search_screen/price_range_widget.dart';

class FilterSortContainer extends StatefulWidget {
  final List<ProductSortType> sortTypes;
  final bool isFromFav;
  final ProductSortType? selectedSortType;
  final Function(ProductSortType) onSortSelected;
  final ProductFilterOrSortType? filterOrSortType;
  final Function() onConfirmFilter;

  const FilterSortContainer({
    super.key,
    required this.sortTypes,
    required this.selectedSortType,
    required this.onSortSelected,
    required this.filterOrSortType,
    required this.onConfirmFilter, required this.isFromFav,
  });

  @override
  State<FilterSortContainer> createState() => _FilterSortContainerState();
}

class _FilterSortContainerState extends State<FilterSortContainer> {
  final Map<String, bool> _filterStates = {};

  void _toggleFilter(String key, bool value) {
    setState(() {
      _filterStates[key] = value;
    });
  }

  void _resetFilters() {
    setState(() {
      _filterStates.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.filterOrSortType != null
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SortWidget(
                  iconColor: widget.filterOrSortType ==
                          ProductFilterOrSortType.filter
                      ? UiConstants.blueColor
                      : UiConstants.black3Color.withOpacity(.6),
                  style: widget.filterOrSortType ==
                          ProductFilterOrSortType.filter
                      ? UiConstants.textStyle11
                          .copyWith(color: UiConstants.blueColor)
                      : UiConstants.textStyle11,
                  text: 'Фильтр',
                  iconPath: Paths.sortIconPath,
                  onTap: () {
                     widget.isFromFav ?
                    context
                        .read<FavoriteProductsScreenBloc>()
                        .add(ShowFilterProductsTypes()):
                      context
                        .read<prod.ProductsScreenBloc>()
                        .add(prod.ShowFilterProductsTypes());  

                  },
                ),
              ),
              Expanded(
                child: SortWidget(
                  iconColor:
                      widget.filterOrSortType == ProductFilterOrSortType.sort
                          ? UiConstants.blueColor
                          : UiConstants.black3Color.withOpacity(.6),
                  style:
                      widget.filterOrSortType == ProductFilterOrSortType.sort
                          ? UiConstants.textStyle11
                              .copyWith(color: UiConstants.blueColor)
                          : UiConstants.textStyle11,
                  text: 'Сортировка',
                  iconPath: Paths.filtersIconPath,
                  onTap: () {
                    widget.isFromFav ?
                    context
                        .read<FavoriteProductsScreenBloc>()
                        .add(ShowSortProductsTypes()):
                      context
                        .read<prod.ProductsScreenBloc>()
                        .add(prod.ShowSortProductsTypes());  

                  },
                ),
              ),
            ],
          ),
          if (widget.filterOrSortType == ProductFilterOrSortType.sort)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 8.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  widget.sortTypes.length,
                  (index) {
                    final productSortType = widget.sortTypes[index];
                    return CustomRadioButton(
                      isLabelOnLeft: false,
                      title: productSortType.displayName,
                      textStyle: UiConstants.textStyle2,
                      value: productSortType,
                      groupValue: widget.selectedSortType,
                      onChanged: (value) =>
                          widget.onSortSelected(productSortType),
                    );
                  },
                ),
              ),
            ),
          if (widget.filterOrSortType == ProductFilterOrSortType.filter)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 500,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Аптека',
                      style: UiConstants.textStyle2
                          .copyWith(color: UiConstants.darkBlueColor),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Не выбрана',
                      style: UiConstants.textStyle11
                          .copyWith(color: UiConstants.black2Color),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          'Выбрать на карте',
                          style: UiConstants.textStyle11.copyWith(
                            color: UiConstants.black3Color.withOpacity(.6),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward_ios,
                            color: UiConstants.black3Color.withOpacity(.6),
                            size: 13)
                      ],
                    ),
                    SizedBox(height: 16.h),
                    DropdownBlockTemplate(
                      title: 'Бренд',
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String key = 'Бренд $index';
                          return DropdownBlockItem(
                            text: key,
                            isChecked: _filterStates[key] ?? false,
                            onChanged: (isChecked) =>
                                _toggleFilter(key, isChecked ?? false),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount: 5,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    DropdownBlockTemplate(
                      title: 'Форма выпуска',
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String key = 'Форма выпуска $index';
                          return DropdownBlockItem(
                            text: key,
                            isChecked: _filterStates[key] ?? false,
                            onChanged: (isChecked) =>
                                _toggleFilter(key, isChecked ?? false),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount: 5,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    DropdownBlockTemplate(
                      title: 'Действующее вещество',
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String key = 'Действующее вещество $index';
                          return DropdownBlockItem(
                            text: key,
                            isChecked: _filterStates[key] ?? false,
                            onChanged: (isChecked) =>
                                _toggleFilter(key, isChecked ?? false),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount: 5,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    DropdownBlockTemplate(
                      title: 'Группа товаров',
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String key = 'Группа товаров $index';
                          return DropdownBlockItem(
                            text: key,
                            isChecked: _filterStates[key] ?? false,
                            onChanged: (isChecked) =>
                                _toggleFilter(key, isChecked ?? false),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount: 5,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    DropdownBlockTemplate(
                      title: 'Страна',
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String key = 'Страна $index';
                          return DropdownBlockItem(
                            text: key,
                            isChecked: _filterStates[key] ?? false,
                            onChanged: (isChecked) =>
                                _toggleFilter(key, isChecked ?? false),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount: 5,
                      ),
                    ),
                    Padding(
                      padding: getMarginOrPadding(top: 16, bottom: 16),
                      child: Divider(
                        color: UiConstants.white5Color,
                      ),
                    ),
                    DropdownBlockItem(
                      text: 'Участвует в акции',
                      isChecked: _filterStates['Участвует в акции'] ?? false,
                      onChanged: (isChecked) => _toggleFilter(
                          'Участвует в акции', isChecked ?? false),
                    ),
                    SizedBox(height: 16.h),
                    PriceRangeWidget(),
                    SizedBox(height: 16.h),
                    AppButtonWidget(
                        text: 'Применить', onTap: widget.onConfirmFilter),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: _resetFilters,
                      child: Text('Сбросить фильтры',
                          style: UiConstants.textStyle11.copyWith(
                            color: UiConstants.black3Color.withOpacity(.6),
                          ),
                          textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
