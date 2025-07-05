part of 'main_screen_bloc.dart';

class MainScreenState extends Equatable {
  final bool isLoading;
  final String? error;
  final PaginatedStoriesEntity? stories;
  final LoyaltyCardQREntity? loyalCard;
  final List<ProductEntity> newProducts;
  final List<ProductEntity> recommendedProducts;
  final List<ProductEntity> popularProducts;
  final List<PromotionEntity> promotions;

  const MainScreenState({
    this.isLoading = true,
    this.error,
    this.stories,
    this.loyalCard,
    this.newProducts = const [],
    this.recommendedProducts = const [],
    this.popularProducts = const [],
    this.promotions = const [],
  });

  MainScreenState copyWith({
    bool? isLoading,
    String? error,
    PaginatedStoriesEntity? stories,
    LoyaltyCardQREntity? loyalCard,
    List<ProductEntity>? newProducts,
    List<ProductEntity>? recommendedProducts,
    List<ProductEntity>? popularProducts,
    List<PromotionEntity>? promotions,
  }) {
    return MainScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      stories: stories ?? this.stories,
      loyalCard: loyalCard ?? this.loyalCard,
      newProducts: newProducts ?? this.newProducts,
      recommendedProducts: recommendedProducts ?? this.recommendedProducts,
      popularProducts: popularProducts ?? this.popularProducts,
      promotions: promotions ?? this.promotions,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        stories,
        loyalCard,
        newProducts,
        recommendedProducts,
        popularProducts,
        promotions
      ];
}
