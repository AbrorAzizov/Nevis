import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/data/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getMe();
  Future<void> updateMe(ProfileModel profile);
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
      final person = data;
      return ProfileModel.fromJson(person);
    } catch (e) {
      log('Error during getMe: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> updateMe(ProfileModel profile) async {
    try {
      Map<String, dynamic> body = Map.from(profile.toJson()['personal_info'])
        ..removeWhere((key, value) => value == null);

      await apiClient.put(
        endpoint: 'users/profile',
        exceptions: {500: ServerException()},
        body: body,
        callPathNameForLog: '${runtimeType.toString()}.updateMe',
      );
    } catch (e) {
      log('Error during updateMe: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> deleteMe() async {
    try {
      final data = await apiClient.delete(
        endpoint: 'users/delete',
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
