import '../../domain/entities/loyalty_card_entity.dart';

class LoyaltyCardInfoModel extends LoyaltyCardEntity {
  const LoyaltyCardInfoModel({
    required super.cardNumber,
    required super.cardType,
    required super.bonusBalance,
    required super.isActive,
  });

  factory LoyaltyCardInfoModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyCardInfoModel(
      cardNumber: json['card_number'] as String,
      cardType: json['card_type'] as String,
      bonusBalance: json['bonus_balance'] as int,
      isActive: json['is_active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card_number': cardNumber,
      'card_type': cardType,
      'bonus_balance': bonusBalance,
      'is_active': isActive,
    };
  }
}
