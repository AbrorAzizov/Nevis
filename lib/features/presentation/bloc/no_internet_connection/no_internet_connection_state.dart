part of 'no_internet_connection_bloc.dart';

class NoInternetConnectionState extends Equatable {
  final LoyaltyCardQREntity? loyalCard;

  const NoInternetConnectionState({
    this.loyalCard,
  });

  NoInternetConnectionState copyWith({
    LoyaltyCardQREntity? loyalCard,
  }) {
    return NoInternetConnectionState(
      loyalCard: loyalCard ?? this.loyalCard,
    );
  }

  @override
  List<Object?> get props => [
        loyalCard,
      ];
}
