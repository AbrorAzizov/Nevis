import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/data/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getMe();
  Future<String?> updateMe(ProfileModel profile);
  Future<void> deleteMe();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProfileRemoteDataSourceImpl({
    required this.apiClient,
    required this.sharedPreferences,
  });

  @override
  Future<ProfileModel> getMe() async {
    try {
      final data = await apiClient.get(
        endpoint: 'users/profile',
        callPathNameForLog: '${runtimeType.toString()}.getMe',
      );

      //final person = data;
      return ProfileModel();
    } catch (e) {
      log('Error during getMe: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<String?> updateMe(ProfileModel profile) async {
    try {
      final data = await apiClient.put(
        endpoint: 'profile/update',
        body: profile.toJson(),
        callPathNameForLog: '${runtimeType.toString()}.updateMe',
      );

      switch (data['statusCode']) {
        case 200:
          return data['data']['code'];
        case 409:
          final error = data['data']['error'];
          if (error.toString().contains('SMS')) {
            return data['data']['code'].toString();
          } else if (error.toString().contains('СМС')) {
            throw SendingCodeTooOftenException();
          }
          throw AcceptPersonalDataException();
        default:
          throw ServerException();
      }
    } catch (e) {
      log('Error during updateMe: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> deleteMe() async {
    try {
      final data = await apiClient.delete(
        endpoint: 'profile/delete',
        callPathNameForLog: '${runtimeType.toString()}.deleteMe',
      );

      if (data['statusCode'] != 200) {
        throw ServerException();
      } else {
        // Remove token from SharedPreferences
        sharedPreferences.remove(SharedPreferencesKeys.accessToken);
      }
    } catch (e) {
      log('Error during deleteMe: $e', level: 1000);
      rethrow;
    }
  }
}

class MockProfileRemoteDataSource implements ProfileRemoteDataSource {
  final SharedPreferences sharedPreferences;

  MockProfileRemoteDataSource({required this.sharedPreferences});

  @override
  Future<ProfileModel> getMe() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final jsonString =
        await rootBundle.loadString('assets/mock_profile_response.json');
    final data = jsonDecode(jsonString);
    return ProfileModel.fromJson(data['data']);
  }

  @override
  Future<String?> updateMe(ProfileModel profile) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final jsonString =
        await rootBundle.loadString('assets/mock_profile_update_response.json');
    final data = jsonDecode(jsonString);
    return data['data']['code'];
  }

  @override
  Future<void> deleteMe() async {
    await Future.delayed(const Duration(milliseconds: 500));
    sharedPreferences.remove(SharedPreferencesKeys.accessToken);
  }
}
