import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';

abstract class PharmacyRemoteDataSource {
  Future<List<PharmacyModel>> getFavoritePharmacies();
}

class PharmacyRemoteDataSourceImpl implements PharmacyRemoteDataSource {
  final ApiClient apiClient;

  PharmacyRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<PharmacyModel>> getFavoritePharmacies() async {
    try {
      final data = await apiClient.get(
        endpoint: 'favorites/pharmacies',
        exceptions: {
          401: ServerException(),
          400: NoFavoritePharmaciesException()
        },
        callPathNameForLog: '${runtimeType.toString()}.getFavoritePharmacies',
      );
      List<dynamic> dataList = data['data'] ?? [];
      return [];
    } on NoFavoritePharmaciesException {
      return [];
    } catch (e) {
      log('Error during getFavoritePharmacies: $e',
          name: '${runtimeType.toString()}.getFavoritePharmacies', level: 1000);
      rethrow;
    }
  }
}
