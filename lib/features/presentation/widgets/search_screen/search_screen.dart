import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen(
      {super.key, required this.homeContext, required this.onRedirect});

  final BuildContext homeContext;
  final Function() onRedirect;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (searchContext, searchState) {
        if (searchState.regionSelectionPressed) {
          return Padding(
            padding: getMarginOrPadding(right: 10),
            child: Container(
              height: 168,
              width: 275,
              decoration: BoxDecoration(
                  color: UiConstants.whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r))),
              //MediaQuery.of(context).size.width,

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
        return SizedBox();
      },
    );
  }
}
