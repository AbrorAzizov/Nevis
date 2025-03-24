import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/shared_preferences_keys.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<bool?> isPhoneExists(String phone);
  Future<void> requestCode(String phone);
  Future<void> login(String phone, String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<void> login(String phone, String code) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}auth/login';

    log('POST $url');
    log('Request body: ${jsonEncode({'phone_number': phone, 'verification_code': code})}');

    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json', 
        },
        body: jsonEncode({'phone_number': phone, 'verification_code': code}),
      );
      log('Response ($url): ${response.statusCode} ${response.body}');
      print(response.statusCode);
      switch (response.statusCode) {
        
        case 200:
          
          final data = json.decode(response.body);
          if(data.containsKey('session_token')){
              await sharedPreferences.setString(
              SharedPreferencesKeys.accessToken, data['session_token']);
          break;
          }
          else{
            throw ConfirmationCodeWrongException();
          }
        
         case 401:
          throw ConfirmationCodeWrongException();
        case 429:
          throw TooManyRequestsException();
        default:
          throw ServerException();
      }
    } catch (e) {
      log('Error during login: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}auth/logout';

    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    log('POST $url');

    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $serverToken'
        },
      );
      // очищаем токен
      sharedPreferences.remove(SharedPreferencesKeys.accessToken);

      log('Response ($url): ${response.statusCode} ${response.body}');

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      log('Error during logout: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<void> requestCode(String phone) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}auth/verification-code';

    log('POST $url');
    log('Request body: ${jsonEncode({'phone_number': phone})}');

    try {
     
      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'phone_number': phone}),
      );

      log('Response ($url): ${response.statusCode} ${response.body}');

      switch (response.statusCode) {
        case 200:
          return;
        case 409:
          throw SendingCodeTooOftenException();
        default:
          throw ServerException();
      }
    } catch (e) {
      log('Error during requestCode: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<bool?> isPhoneExists(String phone) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}auth/check';

    log('POST $url');
    log('Request body: ${jsonEncode({'phone': phone})}');

    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'phone': phone}),
      );

      log('Response ($url): ${response.statusCode} ${response.body}');

      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return data['data']['phone'] == 'found';
        case 422:
          throw InvalidFormatException();
        default:
          throw ServerException();
      }
    } catch (e) {
      log('Error during isPhoneExists: $e', level: 1000);
      rethrow;
    }
  }
}
