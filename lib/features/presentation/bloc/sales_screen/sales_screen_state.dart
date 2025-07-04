part of 'sales_screen_bloc.dart';

class SalesScreenState extends Equatable {
  final List<PromotionEntity> promotions;
  final int page;
  final int lastPage;
  final bool isLoading;
  final bool isLoadingFromNextPage;


  const SalesScreenState({
    required this.promotions,
    this.page = 1,
    this.lastPage = 1,
    this.isLoading = false,
    this.isLoadingFromNextPage = false,
  });

  SalesScreenState copyWith({
    final List<PromotionEntity>? promotions,
    final int? page,
    final int? lastPage,
    final bool? isLoading,
    final bool? isLoadingFromNextPage,
  }) {
    return SalesScreenState(
      promotions: promotions ?? this.promotions,
      page: page ?? this.page,
      lastPage: lastPage ?? this.lastPage,
      isLoading: isLoading ?? this.isLoading,
      isLoadingFromNextPage: isLoadingFromNextPage ?? this.isLoadingFromNextPage,
    );
  }

  @override
  List<Object> get props => [
        promotions,
        page,
        lastPage,
        isLoading,
      ];
}
