import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/products_screen/products_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/filter_and_sort_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/products_grid_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String title = args?['title'];

    return BlocProvider(
      create: (context) => ProductsScreenBloc()..add(LoadProductsEvent()),
      child: BlocBuilder<ProductsScreenBloc, ProductsScreenState>(
        builder: (context, state) {
          final bloc = context.read<ProductsScreenBloc>();
          return Scaffold(
            backgroundColor: UiConstants.backgroundColor,
            body: SafeArea(
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
                        Text(title, style: UiConstants.textStyle5),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  if (state.isLoading)
                    Expanded(child: Center(child: CircularProgressIndicator()))
                  else if (state.error != null)
                    Expanded(
                        child: Center(child: Text("Ошибка загрузки данных")))
                  else
                    Expanded(
                      child: SingleChildScrollView(
                        padding: getMarginOrPadding(bottom: 94),
                        child: Column(
                          children: [
                            Padding(
                              padding: getMarginOrPadding(left: 20, right: 20),
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
                            SizedBox(height: 16.h),
                            SizedBox(height: 40.h, child: FilterChips()),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: getMarginOrPadding(left: 20, right: 20),
                              child: ProductsGridWidget(
                                isLoading: false,
                                products: state.products,
                                showCheckbox: false,
                                selectedProductIds: {},
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FilterChips extends StatefulWidget {
  const FilterChips({super.key});

  @override
  _FilterChipsState createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  int _selectedIndex = 0;
  final List<String> categories = ['Аллергия', 'Антибиотики', 'Астма'];

  final ScrollController _scrollController = ScrollController();

  void _scrollToSelectedChip(int index) {
    double chipWidth = 100.0;
    double scrollOffset = index * chipWidth;

    _scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 22.w,
        children: List.generate(categories.length, (index) {
          final bool isSelected = _selectedIndex == index;
          return ChoiceChip(
            selectedColor: UiConstants.blueColor,
            backgroundColor: UiConstants.whiteColor,
            labelStyle: UiConstants.textStyle19.copyWith(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16.r),
            ),
            showCheckmark: false,
            label: Text(categories[index]),
            selected: isSelected,
            onSelected: (bool selected) {
              if (selected) {
                setState(() {
                  _selectedIndex = index;
                });
                _scrollToSelectedChip(index);
              }
            },
          );
        }),
      ),
    );
  }
}
