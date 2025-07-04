part of 'sale_screen_bloc.dart';

abstract class SaleScreenEvent extends Equatable {
  const SaleScreenEvent();

  @override
  List<Object?> get props => [];
}

class GetPromotionEvent extends SaleScreenEvent {
  final int? promotionId;

  const GetPromotionEvent({
    required this.promotionId,
  });

  @override
  List<Object?> get props => [promotionId];
}
