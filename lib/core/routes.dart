import 'package:flutter/material.dart';

class Routes {
  static const String splashScreen = '/';
  static const String loginScreenPhoneCall = '/login_screen_with_phone_call';
  static const String loginScreenWithMessage = '/login_screen_with_message';
  static const String loginScreenWithYandex = '/login_screen_with_yandex';
  static const String codeScreen = '/code_screen';
  static const String accountNotFoundScreen = '/account_not_found_screen';
  static const String homeScreen = '/home_screen';
  static const String categoryScreen = '/category_screen';
  static const String productsScreen = '/products_screen';
  static const String bannerScreen = '/banner_screen';
  static const String mainScreen = '/main_screen';
  static const String catalogScreen = '/catalog_screen';
  static const String cartScreen = '/cart_screen';
  static const String productScreen = '/product_screen';
  static const String pharmaciesScreen = '/pharmacies_screen';
  static const String profileScreen = '/profile_screen';
  static const String personalDataScreen = '/personal_data_screen';
  static const String ordersScreen = '/orders_screen';
  static const String orderScreen = '/order_screen';
  static const String articlesScreen = '/articles_screen';
  static const String articleScreen = '/article_screen';
  static const String newsScreen = '/news_screen';
  static const String newsInternalScreen = '/news_internal_screen';
  static const String salesScreen = '/sales_screen';
  static const String saleScreen = '/sale_screen';
  static const String aboutUsScreen = '/about_us_screen';
  static const String howPlaceOrderScreen = '/how_place_order_screen';
  static const String infoAboutOrderScreen = '/info_about_order_screen';
  static const String selectRegionScreen = '/select_region_screen';
  static const String docsAndInsctructionsScreen =
      '/documents_and_instructions_screen';
  static const String privacyPolicyScreen = '/privacy_policy_screen';
  static const String cancelOrderScreen = '/cancel_order_screen';
  static const String favoritePharmacy = '/favourite_pharmacy_screen';
  static const String favouriteProducts = '/favourite_products_screen';
  static const String valueBuyProductScreen = '/value_buy_product_screen';
  static const String valueBuySuccessfullyOrderedScreen =
      '/value_buy_successfully_ordered_screen';
  static const String activateBonusCardScreen = '/activate_bonus_card_screen';
  static const String registerBonusCardScreen = '/register_bonus_card_screen';
  static const String bonusCardScreen = '/bonus_card_screen';
  static const String orderPickupScreen = '/order_pickup_screen';
  static const String storiesScreen = '/stories_screen';
  static const String orderPickupCartScreen = '/order_pickup_cart_screen';

  static List<String> get allRoutes => [
        splashScreen,
        loginScreenPhoneCall,
        loginScreenWithMessage,
        loginScreenWithYandex,
        codeScreen,
        accountNotFoundScreen,
        homeScreen,
        categoryScreen,
        productsScreen,
        bannerScreen,
        mainScreen,
        catalogScreen,
        cartScreen,
        productScreen,
        pharmaciesScreen,
        profileScreen,
        personalDataScreen,
        ordersScreen,
        orderScreen,
        articlesScreen,
        articleScreen,
        newsScreen,
        newsInternalScreen,
        salesScreen,
        saleScreen,
        aboutUsScreen,
        howPlaceOrderScreen,
        infoAboutOrderScreen,
        selectRegionScreen,
        docsAndInsctructionsScreen,
        privacyPolicyScreen,
        cancelOrderScreen,
        favoritePharmacy,
        favouriteProducts,
        valueBuyProductScreen,
        valueBuySuccessfullyOrderedScreen,
        registerBonusCardScreen,
        orderPickupScreen,
        storiesScreen
      ];

  // Метод для создания анимированного перехода
  static Route createRoute(Widget screen,
      {Duration duration = const Duration(milliseconds: 500),
      RouteSettings? settings}) {
    return PageRouteBuilder(
      transitionDuration: duration, // Задаем время анимации
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Начальная позиция (справа)
        const end = Offset.zero; // Конечная позиция
        const curve = Curves.easeInOut; // Кривая анимации

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      settings: settings,
    );
  }
}
