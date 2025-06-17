import 'package:equatable/equatable.dart';

class LoyaltyCardEntity extends Equatable {
  final String cardNumber;
  final String cardType;
  final int bonusBalance;
  final bool isActive;

  const LoyaltyCardEntity({
    required this.cardNumber,
    required this.cardType,
    required this.bonusBalance,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        cardNumber,
        cardType,
        bonusBalance,
        isActive,
      ];
}

class LoyaltyCardQREntity extends Equatable {
  final String message;
  final String qrCode;
  final String cardNumber;
  final int bonusPoints;

  const LoyaltyCardQREntity({
    required this.message,
    required this.qrCode,
    required this.cardNumber,
    required this.bonusPoints,
  });

  @override
  List<Object?> get props => [
        message,
        qrCode,
        cardNumber,
        bonusPoints,
      ];
}
