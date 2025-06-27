import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/params/login_servece_param.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<bool?> isPhoneExists(String phone);
  Future<void> requestCode(String phone);
  Future<void> login(String phone, String password, String fcmToken);
  Future<void> loginByService(LoginServiceParam loginServiceParam);
  Future<void> refreshToken();
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRemoteDataSourceImpl({
    required this.apiClient,
    required this.sharedPreferences,
  });

  @override
  Future<void> login(String phone, String code, String fcmToken) async {
    try {
      final data = await apiClient.post(
        requireAuth: false,
        endpoint: 'auth/login',
        body: {
          'phone_number': phone,
          'verification_code': code,
          'fcm_token': fcmToken
        },
        exceptions: {
          401: ConfirmationCodeWrongException(),
          429: TooManyRequestsException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.login',
      );
      if (data.containsKey('access_token')) {
        await sharedPreferences.setString(
            SharedPreferencesKeys.accessToken, data['access_token']['token']);
        await sharedPreferences.setString(
            SharedPreferencesKeys.refreshToken, data['refresh_token']['token']);
      } else {
        throw ConfirmationCodeWrongException();
      }
    } catch (e) {
      log('Error during login: $e',
          name: '${runtimeType.toString()}.login', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> loginByService(LoginServiceParam loginServiceParam) async {
    try {
      final data = await apiClient.post(
        requireAuth: false,
        endpoint: 'auth/login',
        body: {
          'service': loginServiceParam.loginServiceType.name,
          'access_token': loginServiceParam.serviceToken,
          'fcm_token': loginServiceParam.fcmToken
        },
        exceptions: {
          429: TooManyRequestsException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.loginByService',
      );

      if (data.containsKey('access_token')) {
        await sharedPreferences.setString(
            SharedPreferencesKeys.accessToken, data['access_token']['token']);
        await sharedPreferences.setString(
            SharedPreferencesKeys.refreshToken, data['refresh_token']['token']);
      } else {
        throw ConfirmationCodeWrongException();
      }
    } catch (e) {
      log('Error during login: $e',
          name: '${runtimeType.toString()}.login', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> refreshToken() async {
    try {
      final data = await apiClient.post(
          requireAuth: false,
          endpoint: 'auth/refresh-token',
          body: {
            'refresh_token':
                sharedPreferences.getString(SharedPreferencesKeys.refreshToken),
          },
          callPathNameForLog: '${runtimeType.toString()}.refreshToken',
          isRetryRequest: false);

      if (data.containsKey('access_token')) {
        await sharedPreferences.setString(
            SharedPreferencesKeys.accessToken, data['access_token']['token']);
        await sharedPreferences.setString(
            SharedPreferencesKeys.refreshToken, data['refresh_token']['token']);
      } else {
        await sharedPreferences.remove(SharedPreferencesKeys.accessToken);
        await sharedPreferences.remove(SharedPreferencesKeys.refreshToken);
        throw ServerException();
      }
    } catch (e) {
      await sharedPreferences.remove(SharedPreferencesKeys.accessToken);
      await sharedPreferences.remove(SharedPreferencesKeys.refreshToken);
      log('Error during login: $e',
          name: '${runtimeType.toString()}.refreshToken', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await apiClient.post(
        endpoint: 'auth/logout',
        exceptions: {
          401: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.logout',
      );

      // Clear token after successful logout
      sharedPreferences.remove(SharedPreferencesKeys.accessToken);
    } catch (e) {
      log('Error during logout: $e',
          name: '${runtimeType.toString()}.logout', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> requestCode(String phone) async {
    try {
      await apiClient.post(
        requireAuth: false,
        endpoint: 'auth/verification-code',
        body: {'phone_number': phone},
        exceptions: {
          409: SendingCodeTooOftenException(),
          429: TooManyRequestsException()
        },
        callPathNameForLog: '${runtimeType.toString()}.requestCode',
      );
    } catch (e) {
      log('Error during requestCode: $e',
          name: '${runtimeType.toString()}.requestCode', level: 1000);
      rethrow;
    }
  }

  @override
  Future<bool?> isPhoneExists(String phone) async {
    try {
      final data = await apiClient.post(
        endpoint: 'auth/check',
        body: {'phone': phone},
        exceptions: {
          422: InvalidFormatException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.isPhoneExists',
      );
      return data['data']['phone'] == 'found';
    } catch (e) {
      log('Error during isPhoneExists: $e',
          name: '${runtimeType.toString()}.isPhoneExists', level: 1000);
      rethrow;
    }
  }
}
