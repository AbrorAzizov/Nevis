import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';

abstract class PharmacyRemoteDataSource {
  Future<List<PharmacyModel>> getFavoritePharmacies();
  Future<List<PharmacyModel>> getPharmacies();
  Future<void> addToFavoritesPharmacy(int id);
  Future<void> removeFromFavoritesPharmacy(int id);
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
      List<dynamic> dataList = data['pharmacies'] ?? [];
      return dataList.map((e) => PharmacyModel.fromJson(e)).toList();
    } on NoFavoritePharmaciesException {
      return [];
    } catch (e) {
      log('Error during getFavoritePharmacies: $e',
          name: '${runtimeType.toString()}.getFavoritePharmacies', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<PharmacyModel>> getPharmacies() async {
    try {
      final data = await apiClient.get(
        endpoint: 'pharmacies?view=list',
        exceptions: {
          401: ServerException(),
          400: NoFavoritePharmaciesException()
        },
        callPathNameForLog: '${runtimeType.toString()}.getPharmacies',
      );
      List<dynamic> dataList = data['pharmacies'] ?? [];
      return dataList.map((e) => PharmacyModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getPharmacies: $e',
          name: '${runtimeType.toString()}.getPharmacies', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> addToFavoritesPharmacy(int id) async {
    try {
      await apiClient.post(
        endpoint: 'favorites/pharmacies',
        body: {
          'pharmacy_id': 3319,
        },
        exceptions: {
          401: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.addToFavoritesPharmacy',
      );
    } catch (e) {
      log('Error during addToFavoritesPharmacy: $e',
          name: '${runtimeType.toString()}.addToFavoritesPharmacy',
          level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> removeFromFavoritesPharmacy(int id) async {
    try {
      await apiClient.delete(
        endpoint: 'favorites/pharmacies',
        body: {
          'pharmacy_id': 3319,
        },
        exceptions: {
          401: ServerException(),
        },
        callPathNameForLog:
            '${runtimeType.toString()}.removeFromFavoritesPharmacy',
      );
    } catch (e) {
      log('Error during removeFromFavoritesPharmacy: $e',
          name: '${runtimeType.toString()}.removeFromFavoritesPharmacy',
          level: 1000);
      rethrow;
    }
  }
}
