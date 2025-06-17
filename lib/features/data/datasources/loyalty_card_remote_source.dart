import 'dart:convert';
import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/data/models/loyalty_card_info_model.dart';
import 'package:nevis/features/data/models/loyalty_card_qr_model.dart';
import 'package:nevis/features/data/models/loyalty_card_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoyaltyCardRemoteDataSource {
  Future<void> registerCard(LoyaltyCardRegisterModel model);
  Future<LoyaltyCardQRModel?> getQRCode();
  Future<LoyaltyCardInfoModel?> getCardInfo();
}

class LoyaltyCardRemoteDataSourceImpl implements LoyaltyCardRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LoyaltyCardRemoteDataSourceImpl(
      {required this.apiClient, required this.sharedPreferences});

  @override
  Future<void> registerCard(LoyaltyCardRegisterModel model) async {
    try {
      await apiClient.post(
        endpoint: 'loyalty-card/register',
        body: model.toJson(),
        exceptions: {
          400: InvalidFormatException(),
          500: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.registerCard',
      );
    } catch (e) {
      log('Error during registerCard: $e',
          name: '${runtimeType.toString()}.registerCard', level: 1000);
      rethrow;
    }
  }

  @override
  Future<LoyaltyCardQRModel?> getQRCode() async {
    await sharedPreferences.remove(SharedPreferencesKeys.loyaltyCard);
    try {
      final data = await apiClient.get(
        endpoint: 'loyalty-card/qr-code',
        exceptions: {500: ServerException()},
        callPathNameForLog: '${runtimeType.toString()}.getQRCode',
      );

      sharedPreferences.setString(
          SharedPreferencesKeys.loyaltyCard, json.encode(data));
      return LoyaltyCardQRModel.fromJson(data);
    } catch (e) {
      log('Error during getQRCode: $e',
          name: '${runtimeType.toString()}.getQRCode', level: 1000);
      rethrow;
    }
  }

  @override
  Future<LoyaltyCardInfoModel?> getCardInfo() async {
    try {
      final data = await apiClient.get(
        endpoint: 'loyalty-card',
        exceptions: {500: ServerException()},
        callPathNameForLog: '${runtimeType.toString()}.getCardInfo',
      );
      return LoyaltyCardInfoModel.fromJson(data);
    } catch (e) {
      log('Error during getCardInfo: $e',
          name: '${runtimeType.toString()}.getCardInfo', level: 1000);
      rethrow;
    }
  }
}
