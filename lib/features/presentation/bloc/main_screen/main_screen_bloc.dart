import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/loyalty_card_entity.dart';
import 'package:nevis/features/domain/entities/paginated_stories_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';
import 'package:nevis/features/domain/usecases/loyalty_card/get_qr_code.dart';
import 'package:nevis/features/domain/usecases/main/get_new_products.dart';
import 'package:nevis/features/domain/usecases/main/get_popular_products.dart';
import 'package:nevis/features/domain/usecases/main/get_promotions.dart';
import 'package:nevis/features/domain/usecases/main/get_recommended_products.dart';
import 'package:nevis/features/domain/usecases/stories/get_stories_usecase.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final GetStoriesUC getStoriesUC;
  final GetQRCodeUC getQRCodeUC;
  final GetNewProductsUC getNewProductsUC;
  final GetPopularProductsUC getPopularProductsUC;
  final GetRecommendedProductsUC getRecommendedProductsUC;
  final GetPromotionsUC getPromotionsUC;

  MainScreenBloc({
    required this.getStoriesUC,
    required this.getQRCodeUC,
    required this.getNewProductsUC,
    required this.getPopularProductsUC,
    required this.getRecommendedProductsUC,
    required this.getPromotionsUC,
  }) : super(
          MainScreenState(),
        ) {
    on<LoadDataEvent>(_onLoadData);
  }

  void _onLoadData(LoadDataEvent event, Emitter<MainScreenState> emit) async {
    PaginatedStoriesEntity? stories;
    LoyaltyCardQREntity? loyalCard;
    List<ProductEntity>? newProducts;
    List<ProductEntity>? popularProducts;
    List<ProductEntity>? recommendedProducts;
    List<PromotionEntity>? promotions;

    final data = await Future.wait(
      [
        getStoriesUC(0),
        getQRCodeUC(),
        getNewProductsUC(),
        getPopularProductsUC(),
        getRecommendedProductsUC(),
        getPromotionsUC(),
        //getCategoriesUC(),
        // getDailyProductsUC(),
      ],
    );

    data.forEachIndexed(
      (index, element) {
        element.fold(
          (_) {},
          (result) => switch (index) {
            0 => stories = result as PaginatedStoriesEntity?,
            1 => loyalCard = result as LoyaltyCardQREntity?,
            2 => newProducts = result as List <ProductEntity>?,
            3 => popularProducts = result as List <ProductEntity>?,
            4 => recommendedProducts = result as List <ProductEntity>?,
            5 => promotions = (result as (List<PromotionEntity>?, int)).$1,
            _ => {},
          },
        );
      },
    );

    emit(state.copyWith(
      isLoading: false,
      stories: stories,
      loyalCard: loyalCard,
      newProducts: newProducts,
      popularProducts: popularProducts,
      recommendedProducts: recommendedProducts,
      promotions: promotions,
    ));
  }
}
