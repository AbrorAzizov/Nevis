import 'dart:developer';

import 'package:nevis/features/domain/entities/promotion_entity.dart';

import '../../../core/api_client.dart';
import '../models/promotion_model.dart';

abstract class PromotionRemoteDataSource {
  Future <PromotionEntity> getPromotion (int promotionId);
}

class PromotionRemoteDataSourceImpl implements PromotionRemoteDataSource {
  final ApiClient apiClient;

  const PromotionRemoteDataSourceImpl ({
    required this.apiClient,
  });

  @override
  Future<PromotionEntity> getPromotion(int promotionId) async {
    try {
      final data = await apiClient.get(
        endpoint: 'promotions/$promotionId',
        callPathNameForLog: '${runtimeType.toString()}.getPromotion',
      );
      print('ВАМ ПРИШЛО: ${data}');
      return PromotionModel.fromJson(data['data']);
    } catch (e) {
      log('Error during getPromotion: $e', level: 1000);
      rethrow;
    }
  }

}