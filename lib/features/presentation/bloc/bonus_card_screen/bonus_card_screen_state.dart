part of 'bonus_card_screen_bloc.dart';

class BonusCardScreenState extends Equatable {
  final bool isLoading;
  final LoyaltyCardQREntity? loyalCard;

  const BonusCardScreenState({
    this.isLoading = true,
    this.loyalCard,
  });

  BonusCardScreenState copyWith({
    bool? isLoading,
    LoyaltyCardQREntity? loyalCard,
  }) {
    return BonusCardScreenState(
      isLoading: isLoading ?? this.isLoading,
      loyalCard: loyalCard ?? this.loyalCard,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        loyalCard,
      ];
}
