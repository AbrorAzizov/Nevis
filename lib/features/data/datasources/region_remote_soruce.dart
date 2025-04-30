import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/features/data/models/region_model.dart';

abstract class RegionRemoteDataSource {
  Future<List<RegionModel>> getRegions();
  Future<void> selectRegion(int id);
}

class RegionRemoteDataSourceImpl implements RegionRemoteDataSource {
  final ApiClient apiClient;
  RegionRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<List<RegionModel>> getRegions() async {
    try {
      final data = await apiClient.get(
        endpoint: 'regions',
        exceptions: {500: ServerException()},
        callPathNameForLog: '${runtimeType.toString()}.regions',
      );
      List<dynamic> dataList = data['regions'];
      return dataList.map((e) => RegionModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during regions: $e',
          name: '${runtimeType.toString()}.regions', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> selectRegion(int id) async {
    try {
      await apiClient.post(
        body: {
          "region_id": id,
        },
        endpoint: 'region',
        exceptions: {500: ServerException()},
        callPathNameForLog: '${runtimeType.toString()}.setRegion',
      );
    } catch (e) {
      log('Error during setRegion: $e',
          name: '${runtimeType.toString()}.setRegion', level: 1000);
      rethrow;
    }
  }
}
