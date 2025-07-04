import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/firebase_manager.dart';
import 'package:nevis/core/geocoder_manager.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/auth_remote_data_source_impl.dart';
import 'package:nevis/features/data/datasources/cart_local_data_source_impl.dart';
import 'package:nevis/features/data/datasources/cart_remote_data_source_implementation.dart';
import 'package:nevis/features/data/datasources/category_remote_data_source_impl.dart';
import 'package:nevis/features/data/datasources/content_remote_data_source_impl.dart';
import 'package:nevis/features/data/datasources/loyalty_card_local_source.dart';
import 'package:nevis/features/data/datasources/loyalty_card_remote_source.dart';
import 'package:nevis/features/data/datasources/main_remote_data_source.dart';
import 'package:nevis/features/data/datasources/order_local_data_source_impl.dart';
import 'package:nevis/features/data/datasources/order_remote_data_source_impl.dart';
import 'package:nevis/features/data/datasources/pharmacy_remote_data_soruce_impl.dart';
import 'package:nevis/features/data/datasources/product_local_data_soruce.dart';
import 'package:nevis/features/data/datasources/product_remote_data_source_impl.dart';
import 'package:nevis/features/data/datasources/profile_remote_data_source_impl.dart';
import 'package:nevis/features/data/datasources/promotion_remote_data_source.dart';
import 'package:nevis/features/data/datasources/region_remote_soruce.dart';
import 'package:nevis/features/data/datasources/search_remote_data_source.dart';
import 'package:nevis/features/data/datasources/story_remote_data_source_impl.dart';
import 'package:nevis/features/data/repositories/auth_repository_impl.dart';
import 'package:nevis/features/data/repositories/cart_repository_impl.dart';
import 'package:nevis/features/data/repositories/category_repository_impl.dart';
import 'package:nevis/features/data/repositories/content_repository_impl.dart';
import 'package:nevis/features/data/repositories/loyalty_card_repository_impl.dart';
import 'package:nevis/features/data/repositories/main_repository_impl.dart';
import 'package:nevis/features/data/repositories/order_repository_impl.dart';
import 'package:nevis/features/data/repositories/pharmacy_repository_impl.dart';
import 'package:nevis/features/data/repositories/product_repository_impl.dart';
import 'package:nevis/features/data/repositories/profile_repository_impl.dart';
import 'package:nevis/features/data/repositories/promotion_repository_impl.dart';
import 'package:nevis/features/data/repositories/region_respository_impl.dart';
import 'package:nevis/features/data/repositories/search_repository_impl.dart';
import 'package:nevis/features/data/repositories/story_repository_impl.dart';
import 'package:nevis/features/domain/repositories/auth_repository.dart';
import 'package:nevis/features/domain/repositories/cart_repository.dart';
import 'package:nevis/features/domain/repositories/category_repository.dart';
import 'package:nevis/features/domain/repositories/content_repository.dart';
import 'package:nevis/features/domain/repositories/loyalty_card_repository.dart';
import 'package:nevis/features/domain/repositories/main_repository.dart';
import 'package:nevis/features/domain/repositories/order_repository.dart';
import 'package:nevis/features/domain/repositories/pharmacy_repository.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';
import 'package:nevis/features/domain/repositories/profile_repository.dart';
import 'package:nevis/features/domain/repositories/promotion_repository.dart';
import 'package:nevis/features/domain/repositories/region_repository.dart';
import 'package:nevis/features/domain/repositories/search_repository.dart';
import 'package:nevis/features/domain/repositories/story_repository.dart';
import 'package:nevis/features/domain/usecases/auth/is_phone_exists.dart';
import 'package:nevis/features/domain/usecases/auth/login.dart';
import 'package:nevis/features/domain/usecases/auth/login_by_service.dart';
import 'package:nevis/features/domain/usecases/auth/logout.dart';
import 'package:nevis/features/domain/usecases/auth/refresh_token.dart';
import 'package:nevis/features/domain/usecases/auth/request_code.dart';
import 'package:nevis/features/domain/usecases/cart/add_product_to_cart.dart';
import 'package:nevis/features/domain/usecases/cart/delete_product_from_cart.dart';
import 'package:nevis/features/domain/usecases/cart/get_cart.dart';
import 'package:nevis/features/domain/usecases/cart/get_order_cart.dart';
import 'package:nevis/features/domain/usecases/category/get_brands.dart';
import 'package:nevis/features/domain/usecases/category/get_categories.dart';
import 'package:nevis/features/domain/usecases/category/get_countries.dart';
import 'package:nevis/features/domain/usecases/category/get_forms.dart';
import 'package:nevis/features/domain/usecases/category/get_subcategories.dart';
import 'package:nevis/features/domain/usecases/content/get_actions.dart';
import 'package:nevis/features/domain/usecases/content/get_articles.dart';
import 'package:nevis/features/domain/usecases/content/get_banners.dart';
import 'package:nevis/features/domain/usecases/content/get_news.dart';
import 'package:nevis/features/domain/usecases/content/get_one_action.dart';
import 'package:nevis/features/domain/usecases/content/get_one_article.dart';
import 'package:nevis/features/domain/usecases/content/get_one_news.dart';
import 'package:nevis/features/domain/usecases/content/get_pharmacies.dart';
import 'package:nevis/features/domain/usecases/loyalty_card/get_card_info.dart';
import 'package:nevis/features/domain/usecases/loyalty_card/get_qr_code.dart';
import 'package:nevis/features/domain/usecases/loyalty_card/register_card.dart';
import 'package:nevis/features/domain/usecases/main/get_new_products.dart';
import 'package:nevis/features/domain/usecases/main/get_popular_products.dart';
import 'package:nevis/features/domain/usecases/main/get_promotions.dart';
import 'package:nevis/features/domain/usecases/main/get_recommended_products.dart';
import 'package:nevis/features/domain/usecases/order/create_order_for_delivery.dart';
import 'package:nevis/features/domain/usecases/order/create_order_for_pickup.dart';
import 'package:nevis/features/domain/usecases/order/get_pharmacies_by_cart.dart';
import 'package:nevis/features/domain/usecases/orders/get_one_order.dart';
import 'package:nevis/features/domain/usecases/orders/get_order_history.dart';
import 'package:nevis/features/domain/usecases/pharmacies/get_favorite_pharmacies.dart';
import 'package:nevis/features/domain/usecases/products/book_bargain_product.dart';
import 'package:nevis/features/domain/usecases/products/delete_from_favorite_products.dart';
import 'package:nevis/features/domain/usecases/products/get_bargain_product.dart';
import 'package:nevis/features/domain/usecases/products/get_category_products.dart';
import 'package:nevis/features/domain/usecases/products/get_daily_products.dart';
import 'package:nevis/features/domain/usecases/products/get_favorite_products.dart';
import 'package:nevis/features/domain/usecases/products/get_one_product.dart';
import 'package:nevis/features/domain/usecases/products/get_product_pharmacies.dart';
import 'package:nevis/features/domain/usecases/products/get_recomendation_products.dart';
import 'package:nevis/features/domain/usecases/products/get_sort_category_products.dart';
import 'package:nevis/features/domain/usecases/products/get_subcategories_products.dart';
import 'package:nevis/features/domain/usecases/products/products_compilation.dart';
import 'package:nevis/features/domain/usecases/products/search_products.dart';
import 'package:nevis/features/domain/usecases/products/update_favorite_products.dart';
import 'package:nevis/features/domain/usecases/profile/delete_me.dart';
import 'package:nevis/features/domain/usecases/profile/get_me.dart';
import 'package:nevis/features/domain/usecases/profile/update_me.dart';
import 'package:nevis/features/domain/usecases/promotion/get_promotion.dart';
import 'package:nevis/features/domain/usecases/regions/get_regions.dart';
import 'package:nevis/features/domain/usecases/regions/select_region.dart';
import 'package:nevis/features/domain/usecases/search/autocomplete_search.dart';
import 'package:nevis/features/domain/usecases/search/search.dart';
import 'package:nevis/features/domain/usecases/stories/get_stories_usecase.dart';
import 'package:nevis/features/domain/usecases/stories/get_story_by_id_usecase.dart';
import 'package:nevis/features/presentation/bloc/article_screen/article_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/articles_screen/articles_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/bonus_card_screen/bonus_card_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/catalog_screen/catalog_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/code_screen/code_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/info_about_order_screen/info_about_order_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/login_screen/login_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/main_screen/main_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/news_internal_screen/news_internal_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/news_screen/news_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/no_internet_connection/no_internet_connection_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_delivery_personal_data_screen/order_delivery_personal_data_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_screen/order_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/product_screen/product_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/products_screen/products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/register_bonus_card_screen/register_bonus_card_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/sale_screen/sale_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/sign_up_screen/sign_up_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/stories/stories_bloc.dart';
import 'package:nevis/features/presentation/bloc/value_buy_product_screen/value_buy_product_screen_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //// BLoC / Cubit
  sl.registerFactory(
    () => SplashScreenBloc(
      sharedPreferences: sl<SharedPreferences>(),
      getMeUC: sl<GetMeUC>(),
    ),
  );
  sl.registerFactory(
    () => LoginScreenBloc(
      requestCodeUC: sl<RequestCodeUC>(),
      loginByService: sl<LoginByServiceUC>(),
    ),
  );
  sl.registerFactory(
    () => SignUpScreenBloc(
      isPhoneExistsUC: sl<IsPhoneExistsUC>(),
    ),
  );
  sl.registerFactory(
    () => CodeScreenBloc(
      requestCodeUC: sl<RequestCodeUC>(),
      loginUC: sl<LoginUC>(),
    ),
  );
  sl.registerFactory(
    () => HomeScreenBloc(),
  );
  sl.registerFactory(
    () => ProfileScreenBloc(logoutUC: sl<LogoutUC>()),
  );
  sl.registerFactory(
    () => PersonalDataScreenBloc(
        getMeUC: sl<GetMeUC>(),
        updateMeUC: sl<UpdateMeUC>(),
        deleteMeUC: sl<DeleteMeUC>()),
  );
  sl.registerFactory(
    () => NewsScreenBloc(
      getNewsUC: sl<GetNewsUC>(),
    ),
  );
  sl.registerFactory(
    () => NewsInternalScreenBloc(
      getOneNewsUC: sl<GetOneNewsUC>(),
    ),
  );
  sl.registerFactory(
    () => ArticlesScreenBloc(
      getArticlesUC: sl<GetArticlesUC>(),
    ),
  );
  sl.registerFactory(
    () => ArticleScreenBloc(
      getOneArticleUC: sl<GetOneArticleUC>(),
    ),
  );
  sl.registerFactory(
    () => CatalogScreenBloc(
      getCategoriesUC: sl<GetCategoriesUC>(),
    ),
  );
  sl.registerFactory(
    () => MainScreenBloc(
      getStoriesUC: sl<GetStoriesUC>(),
      getQRCodeUC: sl<GetQRCodeUC>(),
      getNewProductsUC: sl<GetNewProductsUC>(),
      getPopularProductsUC: sl<GetPopularProductsUC>(),
      getPromotionsUC: sl<GetPromotionsUC>(),
      getRecommendedProductsUC: sl<GetRecommendedProductsUC>(),
    ),
  );
  sl.registerFactory(
    () => ProductsScreenBloc(
      getSubCategoriesUC: sl<GetSubCategoriesUC>(),
      getCategoryProductsUC: sl<GetCategoryProductsUC>(),
      getSortCategoryProductsUC: sl<GetSortCategoryProductsUC>(),
      searchUC: sl<SearchUC>(),
      productsCompilationUC: sl<ProductsCompilationUC>(),
    ),
  );
  sl.registerFactory(
    () => ProductScreenBloc(
      getRecomendationProductsUC: sl<GetRecomendationProductsUC>(),
      getOneProductUC: sl<GetOneProductUC>(),
      getProductPharmaciesUC: sl<GetProductPharmaciesUC>(),
    ),
  );
  sl.registerFactory(
    () => ValueBuyProductScreenBloc(
      getBargainProductUC: sl<GetBargainProductUC>(),
      bookBargainProductUC: sl<BookBargainProductUC>(),
    ),
  );

  sl.registerFactory(
    () => OrderScreenBloc(
      getOneOrderUC: sl<GetOneOrderUC>(),
    ),
  );
  sl.registerFactory(
    () => InfoAboutOrderScreenBloc(
      getPharmaciesUC: sl<GetPharmaciesUC>(),
    ),
  );

  sl.registerLazySingleton(
    () => FavoriteProductsScreenBloc(
      deleteProductFromFavoriteProductsUC:
          sl<DeleteProductFromFavoriteProductsUC>(),
      updateFavoriteProductsUC: sl<UpdateFavoriteProductsUC>(),
      getFavoriteProductsUC: sl<GetFavoriteProductsUC>(),
    ),
  );

  sl.registerLazySingleton(
    () => SearchScreenBloc(
      getRegionsUC: sl(),
      selectRegionUC: sl(),
      autocompleteSearchUC: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => CartScreenBloc(
        getCartProducts: sl(),
        addProductToCart: sl(),
        deleteProductFromCart: sl()),
  );

  sl.registerLazySingleton(
    () => StoriesBloc(getStoryByIdUC: sl()),
  );

  sl.registerLazySingleton(
    () => RegisterBonusCardScreenBloc(getMeUC: sl(), registerCardUC: sl()),
  );

  sl.registerLazySingleton(
    () => NoInternetConnectionBloc(getQRCodeUC: sl()),
  );

  sl.registerLazySingleton(
    () => BonusCardScreenBloc(getQRCodeUC: sl()),
  );
  sl.registerLazySingleton(
    () => OrderDeliveryPersonalDataBloc(
        getMeUC: sl(), createOrderForDeliveryUC: sl()),
  );
  sl.registerLazySingleton(
    () => SaleScreenBloc(
      getPromotionUC: sl(),
    ),
  );

  //// UseCases

  // Regions
  sl.registerLazySingleton(() => GetRegionsUC(sl()));
  sl.registerLazySingleton(() => SelectRegionUC(sl()));

  // Auth
  sl.registerLazySingleton(() => LoginByServiceUC(sl()));
  sl.registerLazySingleton(() => LoginUC(sl()));
  sl.registerLazySingleton(() => LogoutUC(sl()));
  sl.registerLazySingleton(() => RequestCodeUC(sl()));
  sl.registerLazySingleton(() => IsPhoneExistsUC(sl()));
  sl.registerLazySingleton(() => RefreshTokenUC(sl()));

  // Profile
  sl.registerLazySingleton(() => GetMeUC(sl()));
  sl.registerLazySingleton(() => UpdateMeUC(sl()));
  sl.registerLazySingleton(() => DeleteMeUC(sl()));

  // Content
  sl.registerLazySingleton(() => GetActionsUC(sl()));
  sl.registerLazySingleton(() => GetArticlesUC(sl()));
  sl.registerLazySingleton(() => GetBannersUC(sl()));
  sl.registerLazySingleton(() => GetNewsUC(sl()));
  sl.registerLazySingleton(() => GetOneActionUC(sl()));
  sl.registerLazySingleton(() => GetOneArticleUC(sl()));
  sl.registerLazySingleton(() => GetOneNewsUC(sl()));
  sl.registerLazySingleton(() => GetPharmaciesUC(sl()));

  // Product
  sl.registerLazySingleton(() => GetDailyProductsUC(sl()));
  sl.registerLazySingleton(() => GetOneProductUC(sl()));
  sl.registerLazySingleton(() => SearchProductsUC(sl()));
  sl.registerLazySingleton(() => GetProductPharmaciesUC(sl()));
  sl.registerLazySingleton(() => GetCategoryProductsUC(sl()));
  sl.registerLazySingleton(() => GetSortCategoryProductsUC(sl()));
  sl.registerLazySingleton(() => GetSubCategoriesUC(sl()));
  sl.registerLazySingleton(() => GetRecomendationProductsUC(sl()));
  sl.registerLazySingleton(() => GetFavoriteProductsUC(sl()));
  sl.registerLazySingleton(() => UpdateFavoriteProductsUC(sl()));
  sl.registerLazySingleton(() => DeleteProductFromFavoriteProductsUC(sl()));
  sl.registerLazySingleton(() => UpdateSeveralFavoriteProductsUC(sl()));
  sl.registerLazySingleton(() => GetBargainProductUC(sl()));
  sl.registerLazySingleton(() => BookBargainProductUC(sl()));

  // Category
  sl.registerLazySingleton(() => GetCategoriesUC(sl()));
  sl.registerLazySingleton(() => GetSubcategoriesUC(sl()));
  sl.registerLazySingleton(() => GetCountriesUC(sl()));
  sl.registerLazySingleton(() => GetBrandsUC(sl()));
  sl.registerLazySingleton(() => GetFormsUC(sl()));

  // Order
  sl.registerLazySingleton(() => GetOrderHistoryUC(sl()));
  sl.registerLazySingleton(() => GetOneOrderUC(sl()));
  sl.registerLazySingleton(() => GetPharmaciesByCartUC(sl()));
  sl.registerLazySingleton(() => CreateOrderForPickupUC(sl()));
  sl.registerLazySingleton(() => CreateOrderForDeliveryUC(sl()));

  //Cart
  sl.registerLazySingleton(() => GetCartProductsUC(sl()));
  sl.registerLazySingleton(() => AddProductToCartUC(sl()));
  sl.registerLazySingleton(() => DeleteProductFromCartUC(sl()));
  sl.registerLazySingleton(() => GetOrderCartProductsUC(sl()));

  // Pharmacy
  sl.registerLazySingleton(() => GetFavoritePharmaciesUC(sl()));

  // Story
  sl.registerLazySingleton(() => GetStoriesUC(sl()));
  sl.registerLazySingleton(() => GetStoryByIdUC(sl()));

  // Bonus card
  sl.registerLazySingleton(() => RegisterCardUC(sl()));
  sl.registerLazySingleton(() => GetQRCodeUC(sl()));
  sl.registerLazySingleton(() => GetCardInfoUC(sl()));

  // Search
  sl.registerLazySingleton(() => AutocompleteSearchUC(sl()));
  sl.registerLazySingleton(() => SearchUC(sl()));

  // Main
  sl.registerLazySingleton(() => GetNewProductsUC(sl()));
  sl.registerLazySingleton(() => GetPopularProductsUC(sl()));
  sl.registerLazySingleton(() => GetPromotionsUC(sl()));
  sl.registerLazySingleton(() => GetRecommendedProductsUC(sl()));

  // Promotion
  sl.registerLazySingleton(() => GetPromotionUC(sl()));

  //// Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      networkInfo: sl(),
      errorHandler: sl(),
    ),
  );

  sl.registerLazySingleton<RegionRepository>(
    () => RegionRespositoryImpl(
      regionRemoteDataSource: sl(),
      networkInfo: sl(),
      errorHandler: sl(),
    ),
  );

  sl.registerLazySingleton<PharmacyRepository>(
    () => PharmacyRepositoryImpl(
        networkInfo: sl(), errorHandler: sl(), pharmacyRemoteDataSource: sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileRemoteDataSource: sl(),
      networkInfo: sl(),
      errorHandler: sl(),
    ),
  );
  sl.registerLazySingleton<ContentRepository>(
    () => ContentRepositoryImpl(
      contentRemoteDataSource: sl(),
      networkInfo: sl(),
      errorHandler: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productRemoteDataSource: sl(),
      networkInfo: sl(),
      sharedPreferences: sl(),
      errorHandler: sl(),
      productLocaleDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      categoryRemoteDataSource: sl(),
      networkInfo: sl(),
      errorHandler: sl(),
    ),
  );

  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      orderLocalDataSource: sl(),
      orderRemoteDataSource: sl(),
      networkInfo: sl(),
      errorHandler: sl(),
    ),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
        networkInfo: sl(),
        errorHandler: sl(),
        cartRemoteDataSource: sl(),
        cartLocalDataSource: sl(),
        sharedPreferences: sl()),
  );

  sl.registerLazySingleton<StoryRepository>(
    () => StoryRepositoryImpl(
        networkInfo: sl(), errorHandler: sl(), storyRemoteDataSource: sl()),
  );

  sl.registerLazySingleton<LoyaltyCardRepository>(
    () => LoyaltyCardRepositoryImpl(
        networkInfo: sl(),
        errorHandler: sl(),
        remoteDataSource: sl(),
        localDataSource: sl()),
  );

  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      errorHandler: sl(),
    ),
  );

  sl.registerLazySingleton<PromotionRepository>(
    () => PromotionRepositoryImpl(
      promotionRemoteDataSource: sl(),
      networkInfo: sl(),
      errorHandler: sl(),
    ),
  );

  sl.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(
      mainRemoteDataSource: sl(),
      networkInfo: sl(),
      errorHandler: sl(),
    ),
  );

  //// DataSources
  sl.registerLazySingleton<RegionRemoteDataSource>(
    () => RegionRemoteDataSourceImpl(
      apiClient: sl(),
    ),
  );

  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<ProductLocaleDataSource>(
    () => ProductLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      apiClient: sl(),
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      apiClient: sl(),
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<ContentRemoteDataSource>(
    () => ContentRemoteDataSourceImpl(
      apiClient: sl(),
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(
      apiClient: sl(),
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(
      apiClient: sl(),
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(
      apiClient: sl(),
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(
      apiClient: sl(),
    ),
  );

  sl.registerLazySingleton<PharmacyRemoteDataSource>(
    () => PharmacyRemoteDataSourceImpl(
      apiClient: sl(),
    ),
  );

  sl.registerLazySingleton<StoryRemoteDataSource>(
    () => StoryRemoteDataSourceImpl(
      apiClient: sl(),
    ),
  );

  sl.registerLazySingleton<LoyaltyCardRemoteDataSource>(
    () => LoyaltyCardRemoteDataSourceImpl(
        apiClient: sl(), sharedPreferences: sl()),
  );

  sl.registerLazySingleton<LoyaltyCardLocalDataSource>(
    () => LoyaltyCardLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(
      apiClient: sl(),
    ),
  );

  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<PromotionRemoteDataSource>(
    () => PromotionRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<MainRemoteDataSource>(
    () => MainRemoteDataSourceImpl(apiClient: sl()),
  );

  //// Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      client: sl(),
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<ErrorHandler>(
    () => ErrorHandlerImpl(sl()),
  );

  //// External
  await dotenv.load(fileName: ".env");
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(
      () => YandexGeocoder(apiKey: dotenv.env['YANDEX_GEOCODER_API_KEY']!));
  sl.registerLazySingleton(() => GeocoderManager(sl<YandexGeocoder>()));
  sl.registerLazySingleton<FirebaseManager>(() => FirebaseManager());
}
