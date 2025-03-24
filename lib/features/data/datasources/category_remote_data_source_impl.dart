import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/features/data/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories({int? id});
  Future<List<String>> getCountries(int categoryId);
  Future<List<String>> getForms(int categoryId);
  Future<List<String>> getBrands(int categoryId);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  CategoryRemoteDataSourceImpl({
    required this.apiClient,
    required this.sharedPreferences,
  });

  @override
  Future<List<CategoryModel>> getCategories({int? id}) async {
    try {
      final data = await apiClient.get(
        endpoint: 'categories/$id',
        callPathNameForLog: '${runtimeType.toString()}.getCategories',
      );

      List<dynamic> dataList = data['data'];
      return dataList.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getCategories: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<String>> getBrands(int categoryId) async {
    try {
      final data = await apiClient.get(
        endpoint: 'categories/$categoryId/brands/',
        callPathNameForLog: '${runtimeType.toString()}.getBrands',
      );

      List<dynamic> raw = data['data'];
      return List<String>.from(raw.map((item) => item.toString()));
    } catch (e) {
      log('Error during getBrands: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<String>> getCountries(int categoryId) async {
    try {
      final data = await apiClient.get(
        endpoint: 'categories/$categoryId/countries/',
        callPathNameForLog: '${runtimeType.toString()}.getCountries',
      );

      List<dynamic> raw = data['data'];
      return List<String>.from(raw.map((item) => item.toString()));
    } catch (e) {
      log('Error during getCountries: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<String>> getForms(int categoryId) async {
    try {
      final data = await apiClient.get(
        endpoint: 'categories/$categoryId/forms/',
        callPathNameForLog: '${runtimeType.toString()}.getForms',
      );

      List<dynamic> raw = data['data'];
      return List<String>.from(raw.map((item) => item.toString()));
    } catch (e) {
      log('Error during getForms: $e', level: 1000);
      rethrow;
    }
  }
}
