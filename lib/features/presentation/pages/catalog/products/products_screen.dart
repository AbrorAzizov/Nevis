import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/presentation/bloc/products_screen/products_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/filter_and_sort_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/products_grid_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar.dart';
import 'package:nevis/locator_service.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String title = args?['title'];
    final int categoryId = int.parse(args?['id']);

    return BlocProvider(
      create: (context) => ProductsScreenBloc(
          getCategoryProductsUC: sl(),
          getSortCategoryProductsUC: sl(),
          getSubCategoriesUC: sl())
        ..add(LoadProductsEvent(categoryId: categoryId)),
      child: BlocBuilder<ProductsScreenBloc, ProductsScreenState>(
        builder: (context, state) {
          final bloc = context.read<ProductsScreenBloc>();
          return Scaffold(
            backgroundColor: UiConstants.backgroundColor,
            body: Padding(
              padding: getMarginOrPadding(bottom: 0),
              child: SafeArea(
                child: Padding(
                  padding: getMarginOrPadding(bottom: 71),
                  child: Column(
                    children: [
                      SearchProductAppBar(
                        screenContext: context,
                        onTapFavoriteProductsChip: () {},
                        onTapLocationChip: () {},
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: getMarginOrPadding(left: 20, right: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              child: SvgPicture.asset(Paths.arrowBackIconPath),
                              onTap: () => Navigator.pop(context),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                                child:
                                    Text(title, style: UiConstants.textStyle5)),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),

                      // Прокручиваемая часть
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    getMarginOrPadding(left: 20, right: 20),
                                child: FilterSortContainer(
                                  isFromFav: false,
                                  sortTypes: ProductSortType.values,
                                  selectedSortType: state.selectedSortType,
                                  onSortSelected: (sortType) {
                                    bloc.add(SelectSortProductsType(
                                      productSortType: sortType,
                                      categoryId: categoryId,
                                    ));
                                  },
                                  filterOrSortType:
                                      state.selectedFilterOrSortType,
                                  onConfirmFilter: () =>
                                      bloc.add(ShowFilterProductsTypes()),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              SizedBox(
                                height: 33.h,
                                child: FilterChips(
                                  categories: state.subCategories,
                                  selectedCategory: state.selectedSubCategory,
                                  onSelected: (category) {
                                    bloc.add(SelectSubCategoryEvent(
                                        subCategory: category));
                                  },
                                ),
                              ),
                              SizedBox(height: 16.h),
                              // Ваш контент
                              if (state.isLoading)
                                Center(child: CircularProgressIndicator())
                              else if (state.error != null)
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Ошибка загрузки данных"),
                                    ],
                                  ),
                                )
                              else if (state.products.isEmpty)
                                Center(
                                    child:
                                        Text("Нет товаров в выбранной группе"))
                              else
                                Padding(
                                  padding:
                                      getMarginOrPadding(left: 20, right: 20),
                                  child: ProductsGridWidget(
                                    products: state.products,
                                    showCheckbox: false,
                                    selectedProductIds: {},
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FilterChips extends StatelessWidget {
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
  final Function(CategoryEntity category) onSelected;

  const FilterChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFF144B63).withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: -4,
            offset: Offset(-1, -4),
          ),
        ]),
        child: Padding(
          padding: getMarginOrPadding(left: 20),
          child: Row(
            children: categories.map((category) {
              final bool isSelected =
                  selectedCategory?.categoryId == category.categoryId;
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: Container(
                  child: ChoiceChip(
                    selectedColor: UiConstants.blueColor,
                    backgroundColor: UiConstants.whiteColor,
                    labelStyle: UiConstants.textStyle19.copyWith(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        side: BorderSide(color: Colors.transparent)), // <--),
                    showCheckmark: false,
                    label: Text(category.pageTitle ?? ''),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      if (selected) {
                        onSelected(category);
                      }
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
