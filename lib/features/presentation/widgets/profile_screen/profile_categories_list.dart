import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/profile/docs_and_instructions_screen.dart';
import 'package:nevis/features/presentation/pages/profile/favorite_pharmacies_screen.dart';
import 'package:nevis/features/presentation/pages/profile/favourite_products_screen.dart';
import 'package:nevis/features/presentation/pages/profile/how_place_order_screen.dart';
import 'package:nevis/features/presentation/pages/profile/orders/orders_screen.dart';
import 'package:nevis/features/presentation/pages/profile/personal_data_screen.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_phone_call.dart';
import 'package:nevis/features/presentation/widgets/category_screen/subcategory_item.dart';
import 'package:nevis/locator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileCategoriesList extends StatelessWidget {
  const ProfileCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignorePointer(
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SubcategoryItem(
            title: 'Список заказов',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.boxIconPath,
            onTap: () {
              String? token = sl<SharedPreferences>()
                  .getString(SharedPreferencesKeys.accessToken);
              if (token != null) {
                Navigator.of(context).push(
                  Routes.createRoute(
                    const OrdersScreen(),
                    settings: RouteSettings(name: Routes.ordersScreen),
                  ),
                );
              } else {
                Navigator.of(context.read<HomeScreenBloc>().context!).push(
                  Routes.createRoute(
                    const LoginScreenWithPhoneCall(
                      canBack: true,
                    ),
                    settings: RouteSettings(
                      name: Routes.loginScreenPhoneCall,
                      arguments: {'redirect_type': LoginScreenType.login},
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 8.h),
          SubcategoryItem(
            title: 'Личные данные',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.personalDataIconPath,
            onTap: () {
              String? token = sl<SharedPreferences>()
                  .getString(SharedPreferencesKeys.accessToken);
              if (token != null) {
                Navigator.of(context).push(
                  Routes.createRoute(
                    const PersonalDataScreen(),
                    settings: RouteSettings(name: Routes.personalDataScreen),
                  ),
                );
              } else {
                Navigator.of(context.read<HomeScreenBloc>().context!).push(
                  Routes.createRoute(
                    const LoginScreenWithPhoneCall(
                      canBack: true,
                    ),
                    settings: RouteSettings(
                      name: Routes.loginScreenPhoneCall,
                      arguments: {'redirect_type': LoginScreenType.login},
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 8.h),
          SubcategoryItem(
            title: 'Как сделать заказ?',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.checkOnPaperIconPath,
            onTap: () => Navigator.of(context).push(
              Routes.createRoute(
                const HowPlaceOrderScreen(),
                settings: RouteSettings(name: Routes.howPlaceOrderScreen),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SubcategoryItem(
            title: 'Документы и инструкции',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.documnetsAndInstructionsIconPath,
            onTap: () => Navigator.of(context).push(
              Routes.createRoute(
                const DocumentsAndInstructionsScreen(),
                settings:
                    RouteSettings(name: Routes.docsAndInsctructionsScreen),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SubcategoryItem(
            title: 'Любимые товары',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.favouriteProductsIconPath,
            onTap: () {
              String? token = sl<SharedPreferences>()
                  .getString(SharedPreferencesKeys.accessToken);
              if (token != null) {
                Navigator.of(context).push(
                  Routes.createRoute(
                    const FavoriteProductsScreen(),
                    settings: RouteSettings(name: Routes.favouriteProducts),
                  ),
                );
              } else {
                Navigator.of(context.read<HomeScreenBloc>().context!).push(
                  Routes.createRoute(
                    const LoginScreenWithPhoneCall(
                      canBack: true,
                    ),
                    settings: RouteSettings(
                      name: Routes.loginScreenPhoneCall,
                      arguments: {'redirect_type': LoginScreenType.login},
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 8.h),
          SubcategoryItem(
            title: 'Любимые аптеки',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.favPharmaciesIconPath,
            onTap: () {
              String? token = sl<SharedPreferences>()
                  .getString(SharedPreferencesKeys.accessToken);
              if (token != null) {
                Navigator.of(context).push(
                  Routes.createRoute(
                    const FavoritePharmaciesScreen(),
                    settings: RouteSettings(name: Routes.favoritePharmacy),
                  ),
                );
              } else {
                Navigator.of(context.read<HomeScreenBloc>().context!).push(
                  Routes.createRoute(
                    const LoginScreenWithPhoneCall(
                      canBack: true,
                    ),
                    settings: RouteSettings(
                      name: Routes.loginScreenPhoneCall,
                      arguments: {'redirect_type': LoginScreenType.login},
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
