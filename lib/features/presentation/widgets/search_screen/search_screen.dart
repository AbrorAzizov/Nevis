import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/core/params/search_param.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/catalog/products/product_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen(
      {super.key, required this.homeContext, required this.onRedirect});

  final BuildContext homeContext;
  final Function() onRedirect;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (searchContext, searchState) {
        final searchBloc = context.read<SearchScreenBloc>();
        if (searchState.regions.isEmpty) {
          searchBloc.add(GetRegionsEvent());
        }
        if (searchState.regionSelectionPressed) {
          return Padding(
            padding: getMarginOrPadding(right: 10),
            child: Container(
              height: 168,
              width: MediaQuery.of(context).size.width - 40.w - 32.w - 44.w,
              decoration: BoxDecoration(
                  color: UiConstants.whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r))),
              child: ListView(
                padding: getMarginOrPadding(top: 16, left: 20, right: 16),
                children: [
                  if (searchState.query.isNotEmpty) ...[
                    if (searchState.regionSuggestions.isEmpty &&
                        searchState.errorMessage != null)
                      Text(searchState.errorMessage!),
                    if (searchState.regionSuggestions.isNotEmpty)
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            final region = searchState.regionSuggestions[index];
                            if (region.id != null) {
                              context
                                  .read<SearchScreenBloc>()
                                  .add(SelectRegionEvent(id: region.id!));
                            }
                          },
                          child: Text(
                            searchState.regionSuggestions[index].name ??
                                ' . . .',
                            style: UiConstants.textStyle12.copyWith(
                              height: 1,
                              fontWeight: FontWeight.w400,
                              color: searchState
                                          .regionSuggestions[index].isDefault ??
                                      false
                                  ? UiConstants.blueColor
                                  : UiConstants.black3Color,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15),
                        itemCount: searchState.regionSuggestions.length,
                      ),
                  ] else ...[
                    // Query is empty, show all regions
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          final region = searchState.regions[index];
                          if (region.id != null) {
                            context
                                .read<SearchScreenBloc>()
                                .add(SelectRegionEvent(id: region.id!));
                          }
                        },
                        child: Text(
                          searchState.regions[index].name ?? ' . . .',
                          style: UiConstants.textStyle12.copyWith(
                            height: 1,
                            fontWeight: FontWeight.w400,
                            color: searchState.regions[index].isDefault ?? false
                                ? UiConstants.blueColor
                                : UiConstants.black3Color,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15),
                      itemCount: searchState.regions.length,
                    ),
                  ]
                ],
              ),
            ),
          );
        }
        if (!searchState.regionSelectionPressed &&
            searchState.autocompleteResults != null &&
            searchState.query.length >= 3) {
          // Показываем продукты из автодополнения
          final products = searchState.autocompleteResults!
              .expand((e) => e.products)
              .toList();
          return Padding(
            padding: getMarginOrPadding(right: 10),
            child: Container(
              height: 168,
              width: MediaQuery.of(context).size.width - 40.w - 32.w - 44.w,
              decoration: BoxDecoration(
                color: UiConstants.whiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
              ),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: product.image ?? '',
                      fit: BoxFit.fitHeight,
                      height: 32.h,
                      width: 32.h,
                      cacheManager: CustomCacheManager(),
                      errorWidget: (context, url, error) => Icon(Icons.image,
                          size: 18.w, color: UiConstants.whiteColor),
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                            color: UiConstants.blueColor),
                      ),
                    ),
                    title: Text(
                      product.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      // По клику можно сразу выполнить поиск по продукту
                      context.read<SearchScreenBloc>().add(
                            PerformSearchEvent(
                              SearchParams(query: product.name ?? ''),
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
                            arguments: {'productId': product.productId},
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
