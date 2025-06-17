import '../../domain/entities/loyalty_card_entity.dart';

class LoyaltyCardQRModel extends LoyaltyCardQREntity {
  const LoyaltyCardQRModel({
    required super.message,
    required super.qrCode,
    required super.cardNumber,
    required super.bonusPoints,
  });

  factory LoyaltyCardQRModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyCardQRModel(
      message: json['message'] as String,
      qrCode: json['qr_code'] as String,
      cardNumber: json['card_number'] as String,
      bonusPoints: json['bonus_points'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'qr_code': qrCode,
      'card_number': cardNumber,
      'bonus_points': bonusPoints,
    };
  }
}
