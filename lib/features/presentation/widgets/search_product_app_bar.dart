import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/params/search_param.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/pages/profile/favourite_products_screen.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_phone_call.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchProductAppBar extends StatefulWidget {
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
  State<SearchProductAppBar> createState() => _SearchProductAppBarState();
}

class _SearchProductAppBarState extends State<SearchProductAppBar> {
  late FocusNode _localFocusNode;
  late TextEditingController _localSearchProductController;
  late TextEditingController _localSearchRegionController;

  @override
  void initState() {
    super.initState();
    _localFocusNode = FocusNode();
    _localSearchProductController = TextEditingController();
    _localSearchRegionController = TextEditingController();
  }

  @override
  void dispose() {
    _localFocusNode.dispose();
    _localSearchProductController.dispose();
    _localSearchRegionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchScreenBloc searchBloc = context.read<SearchScreenBloc>();
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (context, state) {
        if (_localSearchProductController.text != state.query &&
            !state.regionSelectionPressed) {
          _localSearchProductController.text = state.query;
        }
        if (_localSearchRegionController.text != state.query &&
            state.regionSelectionPressed) {
          _localSearchRegionController.text = state.query;
        }

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
                  if (widget.onTapBack != null)
                    Padding(
                      padding: getMarginOrPadding(right: 10),
                      child: GestureDetector(
                        onTap: widget.onTapBack,
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
                            focusNode: _localFocusNode,
                            hintText: state.regionSelectionPressed
                                ? ''
                                : 'Поиск товаров',
                            controller: state.regionSelectionPressed
                                ? _localSearchRegionController
                                : _localSearchProductController,
                            fillColor: UiConstants.whiteColor,
                            hintMaxLines: 1,
                            textInputAction: TextInputAction.search,
                            prefixWidget: Skeleton.ignore(
                              child: SvgPicture.asset(Paths.searchIconPath),
                            ),
                            suffixWidget: state.isExpanded
                                ? Skeleton.ignore(
                                    child: GestureDetector(
                                      onTap: () {
                                        searchBloc.add(ClearQueryEvent());
                                        Future.delayed(
                                            Duration(milliseconds: 150), () {
                                          _localFocusNode.unfocus();
                                          context
                                              .read<SearchScreenBloc>()
                                              .add(ClearFocusEvent());
                                        });
                                      },
                                      child:
                                          SvgPicture.asset(Paths.closeIconPath),
                                    ),
                                  )
                                : null,
                            onChangedField: (query) {
                              searchBloc.add(ChangeQueryEvent(query));
                            },
                            onFieldSubmitted: (query) {
                              if (query.isNotEmpty &&
                                  !state.regionSelectionPressed) {
                                searchBloc.add(PerformSearchEvent(
                                    SearchParams(query: query)));
                                _localFocusNode.unfocus();
                                Navigator.of(context
                                        .read<HomeScreenBloc>()
                                        .navigatorKeys[context
                                            .read<HomeScreenBloc>()
                                            .selectedPageIndex]
                                        .currentContext!)
                                    .push(
                                  Routes.createRoute(
                                    const ProductsScreen(),
                                    settings: RouteSettings(
                                      name: Routes.productScreen,
                                      arguments: {
                                        'searchParams':
                                            SearchParams(query: query),
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                            onTapOutside: (event) {
                              Future.delayed(Duration(milliseconds: 150), () {
                                _localFocusNode.unfocus();
                                context
                                    .read<SearchScreenBloc>()
                                    .add(ClearFocusEvent());
                              });
                            },
                            onTap: () =>
                                searchBloc.add(ToggleExpandCollapseEvent(true)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.showFavoriteProductsChip)
                    Padding(
                      padding: getMarginOrPadding(left: 12),
                      child: Skeleton.replace(
                        child: GestureDetector(
                          onTap: () {
                            _localFocusNode.unfocus();

                            String? token = sl<SharedPreferences>()
                                .getString(SharedPreferencesKeys.accessToken);
                            if (token == null) {
                              Navigator.of(
                                      context.read<HomeScreenBloc>().context!)
                                  .push(
                                Routes.createRoute(
                                  const LoginScreenWithPhoneCall(
                                    canBack: true,
                                  ),
                                  settings: RouteSettings(
                                    name: Routes.loginScreenPhoneCall,
                                    arguments: {
                                      'redirect_type': LoginScreenType.login
                                    },
                                  ),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                Routes.createRoute(
                                  const FavoriteProductsScreen(),
                                  settings: RouteSettings(
                                      name: Routes.favouriteProducts),
                                ),
                              );
                            }
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
