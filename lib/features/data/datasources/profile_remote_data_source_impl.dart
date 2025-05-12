import 'dart:developer';

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
        endpoint: 'profile',
        callPathNameForLog: '${runtimeType.toString()}.getMe',
      );

      final person = data;
      print(data);
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
