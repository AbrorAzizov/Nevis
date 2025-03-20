import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/pages/cart/cart_screen.dart';
import 'package:nevis/features/presentation/pages/catalog/catalog_screen.dart';
import 'package:nevis/features/presentation/pages/catalog/category_screen.dart';
import 'package:nevis/features/presentation/pages/catalog/pharmacies_screen.dart';
import 'package:nevis/features/presentation/pages/catalog/products/product_screen.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/pages/home_screen.dart';
import 'package:nevis/features/presentation/pages/main/banner_screen.dart';
import 'package:nevis/features/presentation/pages/main/main_screen.dart';
import 'package:nevis/features/presentation/pages/profile/about_us_screen.dart';
import 'package:nevis/features/presentation/pages/profile/articles/article_screen.dart';
import 'package:nevis/features/presentation/pages/profile/articles/articles_screen.dart';
import 'package:nevis/features/presentation/pages/profile/cancel_order_screen.dart';
import 'package:nevis/features/presentation/pages/profile/favorite_pharmacy_screen.dart';
import 'package:nevis/features/presentation/pages/profile/favourite_products_screen.dart';
import 'package:nevis/features/presentation/pages/profile/how_place_order_screen.dart';
import 'package:nevis/features/presentation/pages/profile/info_about_order_screen.dart';
import 'package:nevis/features/presentation/pages/profile/news/news_internal_screen.dart';
import 'package:nevis/features/presentation/pages/profile/news/news_screen.dart';
import 'package:nevis/features/presentation/pages/profile/orders/order_screen.dart';
import 'package:nevis/features/presentation/pages/profile/orders/orders_screen.dart';
import 'package:nevis/features/presentation/pages/profile/personal_data_screen.dart';
import 'package:nevis/features/presentation/pages/profile/privacy_policy_screen.dart';
import 'package:nevis/features/presentation/pages/profile/profile_screen.dart';
import 'package:nevis/features/presentation/pages/profile/sales_screen.dart';
import 'package:nevis/features/presentation/pages/starts/account_not_found_screen.dart';
import 'package:nevis/features/presentation/pages/starts/code_screen.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_message.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_phone_call.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_yandex.dart';
import 'package:nevis/features/presentation/pages/starts/splash_screen.dart';

import 'locator_service.dart' as di;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initializeDateFormatting('ru', null);
  await di.init();

  runApp(const MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Size designSize =
        const Size(360, 728 + kToolbarHeight + kBottomNavigationBarHeight);
    return ScreenUtilInit(
      designSize: designSize,
      fontSizeResolver: (fontSize, instance) {
        final display = View.of(context).display;
        final screenSize = display.size / display.devicePixelRatio;
        final scaleWidth = screenSize.width / designSize.width;

        return fontSize * scaleWidth;
      },
      //inTextAdapt: true,
      //splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
            title: 'InLek',
            theme: ThemeData(
                scaffoldBackgroundColor: UiConstants.whiteColor,
                fontFamily: 'Nunito'),
            //home: HomeScreen(),
            routes: {
              Routes.splashScreen: (context) => const SplashScreen(),
              Routes.codeScreen: (context) => const CodeScreen(),
              Routes.loginScreenPhoneCall: (context) =>
                  const LoginScreenWithPhoneCall(),
              Routes.accountNotFoundScreen: (context) =>
                  const AccountNotFoundScreen(),
              Routes.homeScreen: (context) => const HomeScreen(),
              Routes.mainScreen: (context) => const MainScreen(),
              Routes.catalogScreen: (context) => const CatalogScreen(),
              Routes.cartScreen: (context) => const CartScreen(),
              Routes.categoryScreen: (context) => const CategoryScreen(),
              Routes.productsScreen: (context) => const ProductsScreen(),
              Routes.bannerScreen: (context) => const BannerScreen(),
              Routes.productScreen: (context) => const ProductScreen(),
              Routes.pharmaciesScreen: (context) => const PharmaciesScreen(),
              Routes.profileScreen: (context) => const ProfileScreen(),
              Routes.personalDataScreen: (context) =>
                  const PersonalDataScreen(),
              Routes.ordersScreen: (context) => const OrdersScreen(),
              Routes.orderScreen: (context) => const OrderScreen(),
              Routes.articlesScreen: (context) => const ArticlesScreen(),
              Routes.articleScreen: (context) => const ArticleScreen(),
              Routes.newsScreen: (context) => const NewsScreen(),
              Routes.newsInternalScreen: (context) =>
                  const NewsInternalScreen(),
              Routes.salesScreen: (context) => const SalesScreen(),
              Routes.aboutUsScreen: (context) => const AboutUsScreen(),
              Routes.howPlaceOrderScreen: (context) =>
                  const HowPlaceOrderScreen(),
              Routes.infoAboutOrderScreen: (context) =>
                  const InfoAboutOrderScreen(),
              Routes.loginScreenWithMessage: (context) =>
                  const LoginScreenWithMessage(),
              Routes.loginScreenWithYandex: (context) =>
                  const LoginScreenWithYandex(),
              Routes.privacyPolicyScreen: (context) =>
                  const PrivacyPolicyScreen(),
              Routes.cancelOrderScreen: (context) => const CancelOrderScreen(),
              Routes.favoritePharmacy: (context) =>
                  const FavoritePharmaciesScreen(),
              Routes.favouriteProducts: (context) =>
                  const FavoriteProductsScreen()
            },
            initialRoute: Routes.splashScreen,
            navigatorObservers: [routeObserver],
            debugShowCheckedModeBanner: false);
      },
    );
  }
}

// На случай, если Пятисотый забыл сертификаты обновить

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
