import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/widgets/search_screen/popularity_requests_widget.dart';
import 'package:nevis/features/presentation/widgets/search_screen/search_history_widget.dart';
import 'package:nevis/features/presentation/widgets/search_screen/search_products_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen(
      {super.key, required this.homeContext, required this.onRedirect});

  final BuildContext homeContext;
  final Function() onRedirect;

  @override
  Widget build(BuildContext context) {
    HomeScreenBloc homeBloc = homeContext.read<HomeScreenBloc>();
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (searchContext, searchState) {
        final SearchScreenBloc searchBloc = context.read<SearchScreenBloc>();
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: UiConstants.backgroundColor,
          child: ListView(
            padding:
                getMarginOrPadding(top: 16, bottom: 140, left: 20, right: 20),
            children: [
              if (searchState.query.isEmpty)
                SearchHistoryWidget()
              else
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () async {
                            await onRedirect();

                            searchBloc.add(
                              SelectSuggestionsEvent(
                                searchState.suggestions[index],
                              ),
                            );

                            homeBloc.navigatorKeys[homeBloc.selectedPageIndex]
                                .currentState
                                ?.push(
                              Routes.createRoute(
                                const ProductsScreen(),
                                settings:
                                    RouteSettings(name: Routes.productsScreen),
                              ),
                            );
                          },
                          child: Text(searchState.suggestions[index],
                              style: UiConstants.textStyle3
                                  .copyWith(color: UiConstants.darkBlueColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemCount: searchState.suggestions.length),
              Container(
                padding: getMarginOrPadding(top: 16, bottom: 16),
                height: 34.h,
                child: Divider(color: UiConstants.white5Color, thickness: 2.h),
              ),
              if (searchState.query.isEmpty)
                PopularityRequestsWidget()
              else
                SearchProductsWidget(),
            ],
          ),
        );
      },
    );
  }
}
