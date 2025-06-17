import 'dart:convert';
import 'dart:developer';

import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/data/models/loyalty_card_qr_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoyaltyCardLocalDataSource {
  Future<LoyaltyCardQRModel?> getQRCode();
}

class LoyaltyCardLocalDataSourceImpl implements LoyaltyCardLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoyaltyCardLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<LoyaltyCardQRModel?> getQRCode() async {
    try {
      String? loyaltyCardJson =
          sharedPreferences.getString(SharedPreferencesKeys.loyaltyCard);
      if (loyaltyCardJson != null) {
        return LoyaltyCardQRModel.fromJson(json.decode(loyaltyCardJson));
      }
      return null;
    } catch (e) {
      log('Error during getQRCode: $e',
          name: '${runtimeType.toString()}.getQRCode', level: 1000);
      rethrow;
    }
  }
}
