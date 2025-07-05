import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/params/search_param.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/catalog/products/product_screen.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/widgets/search_screen/search_product_widget.dart';
import 'package:searchfield/searchfield.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductSearchField extends StatelessWidget {
  const ProductSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (context, state) {
        final bloc = context.read<SearchScreenBloc>();

        return Skeleton.ignorePointer(
          child: Skeleton.shade(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF144B63).withOpacity(0.1),
                    blurRadius: 50,
                    spreadRadius: -4,
                    offset: Offset(-1, -4),
                  ),
                ],
              ),
              child: SearchField<ProductEntity>(
                controller: controller,
                suggestionItemDecoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.none),
                ),
                maxSuggestionBoxHeight: 124.h,
                hint: 'Поиск товаров',
                suggestions: [],
                textInputAction: TextInputAction.search,
                searchInputDecoration: SearchInputDecoration(
                    fillColor: UiConstants.whiteColor,
                    filled: true,
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    contentPadding: getMarginOrPadding(
                        left: 16, right: 16, top: 10, bottom: 10),
                    hintStyle: UiConstants.textStyle3.copyWith(
                        color: UiConstants.darkBlue2Color.withOpacity(.6),
                        height: 1),
                    prefixIcon: Padding(
                      padding: getMarginOrPadding(left: 16, right: 12),
                      child: SvgPicture.asset(Paths.searchIconPath),
                    ),
                    prefixIconConstraints: BoxConstraints(maxWidth: 52.w),
                    suffixIconConstraints: BoxConstraints(maxWidth: 52.w),
                    suffixIcon: controller.text.isNotEmpty
                        ? Skeleton.ignore(
                            child: GestureDetector(
                              onTap: () {
                                controller.clear();
                                FocusScope.of(context).unfocus();
                              },
                              child: SvgPicture.asset(Paths.closeIconPath),
                            ),
                          )
                        : null),
                suggestionsDecoration: SuggestionDecoration(
                  color: UiConstants.whiteColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16.r),
                  ),
                ),
                keepSearchOnSelection: false,
                onSearchTextChanged: (String query) async {
                  if (query.length < 3) return [];
                  List<ProductEntity> products =
                      await bloc.getProductSuggestions(query);
                  return products
                      .map(
                        (product) => SearchFieldListItem<ProductEntity>(
                          product.name ?? '',
                          item: product,
                          child: SearchProductWidget(product: product),
                        ),
                      )
                      .toList();
                },
                onSubmit: (p0) {
                  Navigator.of(context
                          .read<HomeScreenBloc>()
                          .navigatorKeys[
                              context.read<HomeScreenBloc>().selectedPageIndex]
                          .currentContext!)
                      .push(
                    Routes.createRoute(
                      const ProductsScreen(),
                      settings: RouteSettings(
                        name: Routes.productsScreen,
                        arguments: {'searchParams': SearchParams(query: p0)},
                      ),
                    ),
                  );
                },
                onSuggestionTap: (SearchFieldListItem<ProductEntity> item) {
                  if (item.searchKey.isNotEmpty) {
                    bloc.add(
                      PerformSearchEvent(
                        SearchParams(query: item.searchKey),
                      ),
                    );
                    Navigator.of(context
                            .read<HomeScreenBloc>()
                            .navigatorKeys[context
                                .read<HomeScreenBloc>()
                                .selectedPageIndex]
                            .currentContext!)
                        .push(
                      Routes.createRoute(
                        const ProductScreen(),
                        settings: RouteSettings(
                          name: Routes.productScreen,
                          arguments: {'productId': item.item?.productId},
                        ),
                      ),
                    );
                  }
                },
                onTapOutside: (p0) => FocusScope.of(context).unfocus(),
                suggestionState: Suggestion.expand,
              ),
            ),
          ),
        );
      },
    );
  }
}
