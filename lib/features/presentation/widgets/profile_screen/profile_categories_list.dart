import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/pages/profile/about_us_screen.dart';
import 'package:nevis/features/presentation/pages/profile/articles/articles_screen.dart';
import 'package:nevis/features/presentation/pages/profile/how_place_order_screen.dart';
import 'package:nevis/features/presentation/pages/profile/info_about_order_screen.dart';
import 'package:nevis/features/presentation/pages/profile/news/news_screen.dart';
import 'package:nevis/features/presentation/pages/profile/orders/orders_screen.dart';
import 'package:nevis/features/presentation/pages/profile/personal_data_screen.dart';
import 'package:nevis/features/presentation/pages/profile/sales_screen.dart';
import 'package:nevis/features/presentation/widgets/category_screen/subcategory_item.dart';

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
            title: 'Личные данные',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.personalDataIconPath,
            onTap: () => Navigator.of(context).push(
              Routes.createRoute(
                const PersonalDataScreen(),
                settings: RouteSettings(name: Routes.personalDataScreen),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SubcategoryItem(
            title: 'Список заказов',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.boxIconPath,
            onTap: () => Navigator.of(context).push(
              Routes.createRoute(
                const OrdersScreen(),
                settings: RouteSettings(name: Routes.ordersScreen),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SubcategoryItem(
            title: 'Информация о нас',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.crossIconPath,
            onTap: () => Navigator.of(context).push(
              Routes.createRoute(
                const AboutUsScreen(),
                settings: RouteSettings(name: Routes.aboutUsScreen),
              ),
            ),
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
          
        ],
      ),
    );
  }
}
