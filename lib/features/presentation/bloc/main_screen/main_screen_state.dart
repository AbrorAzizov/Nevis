part of 'main_screen_bloc.dart';

class MainScreenState extends Equatable {
  final bool isLoading;
  final String? error;
  final PaginatedStoriesEntity? stories;
  final LoyaltyCardQREntity? loyalCard;
  final List<ProductEntity> newProducts;
  final List<ProductEntity> profitableProducts;

  const MainScreenState({
    this.isLoading = true,
    this.error,
    this.stories,
    this.loyalCard,
    this.newProducts = const [],
    this.profitableProducts = const [],
  });

  MainScreenState copyWith({
    bool? isLoading,
    String? error,
    PaginatedStoriesEntity? stories,
    LoyaltyCardQREntity? loyalCard,
    List<ProductEntity>? newProducts,
    List<ProductEntity>? profitableProducts,
  }) {
    return MainScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      stories: stories ?? this.stories,
      loyalCard: loyalCard ?? this.loyalCard,
      newProducts: newProducts ?? this.newProducts,
      profitableProducts: profitableProducts ?? this.profitableProducts,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        stories,
        loyalCard,
        newProducts,
        profitableProducts,
      ];
}
