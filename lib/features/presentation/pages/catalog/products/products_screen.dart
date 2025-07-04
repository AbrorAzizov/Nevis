import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/params/category_params.dart';
import 'package:nevis/core/params/search_param.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/subcategory_entity.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart'
    as fv;
import 'package:nevis/features/presentation/bloc/products_screen/products_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/filter_and_sort_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/products_grid_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar/search_product_app_bar.dart';
import 'package:nevis/locator_service.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String title = args?['title'] ?? 'Результаты поиска';
    final categoryParams = args?['categoryParams'] as CategoryParams?;
    final products = args?['products'] as List<ProductEntity>?;
    final searchParams = args?['searchParams'] as SearchParams?;
    final productsCompilationType =
        args?['productsCompilationType'] as ProductsCompilationType?;
    final showSortAndFilter = args?['showSortAndFilter'] as bool? ?? true;

    return BlocProvider(
      create: (context) => ProductsScreenBloc(
        getCategoryProductsUC: sl(),
        getSortCategoryProductsUC: sl(),
        getSubCategoriesUC: sl(),
        searchUC: sl(),
        productsCompilationUC: sl(),
        products: products,
        categoryParams: categoryParams,
        searchParams: searchParams,
        productsCompilationType: productsCompilationType,
      )..add(LoadProductsEvent()),
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
                          showFavoriteProductsChip: true,
                          showLocationChip: true),
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
                          controller: bloc.productsController,
                          child: Column(
                            children: [
                              if (showSortAndFilter)
                                Padding(
                                  padding:
                                      getMarginOrPadding(left: 20, right: 20),
                                  child: FilterSortContainer(
                                    isFromFav: false,
                                    sortTypes: ProductSortType.values,
                                    selectedSortType: state.selectedSortType,
                                    onSortSelected: (sortType) {
                                      bloc.add(SelectSortProductsType(
                                          productSortType: sortType));
                                    },
                                    filterOrSortType:
                                        state.selectedFilterOrSortType,
                                    onConfirmFilter: () =>
                                        bloc.add(ShowFilterProductsTypes()),
                                  ),
                                ),
                              if (categoryParams?.categoryId != null)
                                Container(
                                  margin: getMarginOrPadding(top: 16),
                                  height: 33.h,
                                  child: FilterChips(
                                      categories: state.subCategories,
                                      selectedCategory:
                                          state.selectedSubCategory,
                                      onSelected: (category) {
                                        bloc.add(SelectSubCategoryEvent(
                                            subCategory: category));
                                      },
                                      scrollController:
                                          bloc.subCategoriesController),
                                ),
                              SizedBox(height: 16.h),
                              // Ваш контент
                              if (state.isLoading)
                                Center(child: CircularProgressIndicator())
                              else if ((state.searchProducts?.products ?? [])
                                  .isEmpty)
                                Center(
                                    child:
                                        Text("Нет товаров в выбранной группе"))
                              else
                                Padding(
                                  padding:
                                      getMarginOrPadding(left: 20, right: 20),
                                  child: BlocBuilder<
                                      fv.FavoriteProductsScreenBloc,
                                      fv.FavoriteProductsScreenState>(
                                    builder: (context, favState) {
                                      return ProductsGridWidget(
                                        products:
                                            (state.searchProducts?.products ??
                                                []),
                                        showCheckbox: false,
                                        selectedProductIds: {},
                                      );
                                    },
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
  final SubcategoryEntity? categories;
  final GroupEntity? selectedCategory;
  final Function(GroupEntity category) onSelected;
  final ScrollController? scrollController;

  const FilterChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
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
            children: (categories?.groups ?? []).map((category) {
              final bool isSelected = selectedCategory?.id == category.id;
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: Container(
                  child: ChoiceChip(
                    selectedColor: UiConstants.blueColor,
                    backgroundColor: UiConstants.whiteColor,
                    labelStyle: UiConstants.textStyle19.copyWith(
                      color: isSelected
                          ? UiConstants.whiteColor
                          : UiConstants.blueColor,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        side: BorderSide(color: Colors.transparent)),
                    showCheckmark: false,
                    label: Text(category.name ?? ''),
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
