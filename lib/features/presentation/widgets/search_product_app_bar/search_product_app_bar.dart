import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/profile/favourite_products_screen.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_phone_call.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar/product_search_field.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar/region_search_field.dart';
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
  late TextEditingController _controller;
  late VoidCallback _controllerListener;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controllerListener = () {
      setState(() {});
    };
    _controller.addListener(_controllerListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_controllerListener);
    _controller.dispose();
    super.dispose();
  }

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
                      child: state.regionSelectionPressed
                          ? RegionSearchField()
                          : ProductSearchField()),
                  if (widget.showFavoriteProductsChip)
                    Padding(
                      padding: getMarginOrPadding(left: 12),
                      child: Skeleton.replace(
                        child: GestureDetector(
                          onTap: () {
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
