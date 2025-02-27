import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/data/models/category_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories({int? id});
  Future<List<String>> getCountries(int categoryId);
  Future<List<String>> getForms(int categoryId);
  Future<List<String>> getBrands(int categoryId);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  CategoryRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<List<CategoryModel>> getCategories({int? id}) async {
    String baseUrl = dotenv.env['BASE_URL']!;

    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    final uri = Uri.parse('${baseUrl}categories/${id ?? ""}');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    log('GET Request: $uri',
        name: 'CategoryRemoteDataSourceImpl.getCategories');
    log('Headers: $headers',
        name: 'CategoryRemoteDataSourceImpl.getCategories');

    try {
      final response = await client.get(uri, headers: headers);

      log('GET Request: $uri',
          name: 'CategoryRemoteDataSourceImpl.getCategories');
      log('Headers: $headers',
          name: 'CategoryRemoteDataSourceImpl.getCategories');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> dataList = data['data'];

        return dataList.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        log('Error: ServerException occurred',
            name: 'CategoryRemoteDataSourceImpl.getCategories',
            error: response.body);
        throw ServerException();
      }
    } catch (e) {
      log('Error during getCategories: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<String>> getBrands(int categoryId) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    final uri = Uri.parse('${baseUrl}categories/$categoryId/brands/');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    log('GET Request: $uri', name: 'CategoryRemoteDataSourceImpl.getBrands');
    log('Headers: $headers', name: 'CategoryRemoteDataSourceImpl.getBrands');

    try {
      final response = await client.get(uri, headers: headers);

      log('Response Status Code: ${response.statusCode}',
          name: 'CategoryRemoteDataSourceImpl.getBrands');
      log('Response Body: ${response.body}',
          name: 'CategoryRemoteDataSourceImpl.getBrands');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> raw = data['data'];

        List<String> result =
            List<String>.from(raw.map((item) => item.toString()));

        return result;
      } else {
        log('Error: ServerException occurred',
            name: 'CategoryRemoteDataSourceImpl.getBrands',
            error: response.body);
        throw ServerException();
      }
    } catch (e) {
      log('Error during getBrands: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<String>> getCountries(int categoryId) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    final uri = Uri.parse('${baseUrl}categories/$categoryId/countries/');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    log('GET Request: $uri', name: 'CategoryRemoteDataSourceImpl.getCountries');
    log('Headers: $headers', name: 'CategoryRemoteDataSourceImpl.getCountries');

    try {
      final response = await client.get(uri, headers: headers);

      log('Response Status Code: ${response.statusCode}',
          name: 'CategoryRemoteDataSourceImpl.getCountries');
      log('Response Body: ${response.body}',
          name: 'CategoryRemoteDataSourceImpl.getCountries');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> raw = data['data'];

        List<String> result =
            List<String>.from(raw.map((item) => item.toString()));

        return result;
      } else {
        log('Error: ServerException occurred',
            name: 'CategoryRemoteDataSourceImpl.getBrands',
            error: response.body);
        throw ServerException();
      }
    } catch (e) {
      log('Error during getCountries: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<String>> getForms(int categoryId) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    final uri = Uri.parse('${baseUrl}categories/$categoryId/forms/');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    log('GET Request: $uri', name: 'CategoryRemoteDataSourceImpl.getForms');
    log('Headers: $headers', name: 'CategoryRemoteDataSourceImpl.getForms');

    try {
      final response = await client.get(uri, headers: headers);

      log('Response Status Code: ${response.statusCode}',
          name: 'CategoryRemoteDataSourceImpl.getForms');
      log('Response Body: ${response.body}',
          name: 'CategoryRemoteDataSourceImpl.getForms');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> raw = data['data'];

        List<String> result =
            List<String>.from(raw.map((item) => item.toString()));

        return result;
      } else {
        log('Error: ServerException occurred',
            name: 'CategoryRemoteDataSourceImpl.getForms',
            error: response.body);
        throw ServerException();
      }
    } catch (e) {
      log('Error during getForms: $e', level: 1000);
      rethrow;
    }
  }
}
