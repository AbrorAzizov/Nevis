part of 'sale_screen_bloc.dart';

class SaleScreenState extends Equatable {
  final PromotionEntity? promotion;
  final bool isLoading;

  const SaleScreenState({
    this.promotion,
    this.isLoading = false,
  });

  SaleScreenState copyWith({
    final PromotionEntity? promotion,
    final bool? isLoading,
  }) {
    return SaleScreenState(
      promotion: promotion ?? this.promotion,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [promotion, isLoading];
}
