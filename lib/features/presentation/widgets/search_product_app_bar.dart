import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/profile/favourite_products_screen.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchProductAppBar extends StatelessWidget {
  const SearchProductAppBar({
    super.key,
    this.showLocationChip = false,
    this.onTapBack,
    this.screenContext,
    this.showFavoriteProductsChip = false,
  });

  final bool showLocationChip;
  final bool showFavoriteProductsChip;
  final Function()? onTapBack;
  final BuildContext? screenContext;

  @override
  Widget build(BuildContext context) {
    SearchScreenBloc searchBloc = context.read<SearchScreenBloc>();
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: UiConstants.backgroundColor,
          ),
          padding: getMarginOrPadding(top: 8, bottom: 8, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Skeleton.replace(
                    child: GestureDetector(
                      onTap: () {
                        searchBloc.add(ChangeControllerEvent());
                      },
                      child: Padding(
                        padding: getMarginOrPadding(right: 8),
                        child: SvgPicture.asset(
                            state.regionSelectionPressed
                                ? Paths.filledLocationIconPath
                                : Paths.locationIconPath,
                            width: 24.w,
                            height: 24.w),
                      ),
                    ),
                  ),
                  if (onTapBack != null)
                    Padding(
                      padding: getMarginOrPadding(right: 10),
                      child: GestureDetector(
                        onTap: onTapBack,
                        child: SvgPicture.asset(Paths.arrowBackIconPath,
                            color: UiConstants.darkBlue2Color.withOpacity(.6),
                            width: 24.w,
                            height: 24.w),
                      ),
                    ),
                  Expanded(
                    child: Skeleton.ignorePointer(
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
                          child: AppTextFieldWidget(
                            hintText: state.regionSelectionPressed
                                ? ''
                                : 'Поиск товаров',
                            controller: state.regionSelectionPressed
                                ? searchBloc.searchRegionController
                                : searchBloc.searchProductController,
                            fillColor: UiConstants.whiteColor,
                            hintMaxLines: 1,
                            prefixWidget: Skeleton.ignore(
                              child: SvgPicture.asset(Paths.searchIconPath),
                            ),
                            suffixWidget: state.isExpanded
                                ? Skeleton.ignore(
                                    child: GestureDetector(
                                      onTap: () =>
                                          searchBloc.add(ClearQueryEvent()),
                                      child:
                                          SvgPicture.asset(Paths.closeIconPath),
                                    ),
                                  )
                                : null,
                            onChangedField: (query) {
                              searchBloc.add(ChangeQueryEvent(query));
                            },
                            onTapOutside: (event) {},
                            onTap: () =>
                                searchBloc.add(ToggleExpandCollapseEvent(true)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (showFavoriteProductsChip)
                    Padding(
                      padding: getMarginOrPadding(left: 12),
                      child: Skeleton.replace(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).push(
                              Routes.createRoute(
                                const FavoriteProductsScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: getMarginOrPadding(right: 8),
                            child: SvgPicture.asset(
                                Paths.favouriteProductsIconPath,
                                width: 24.w,
                                height: 24.w),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
