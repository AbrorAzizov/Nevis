import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nevis/constants/utils.dart';
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
  final http.Client client;
  final SharedPreferences sharedPreferences;

  ProfileRemoteDataSourceImpl(
      {required this.client, required this.sharedPreferences});

  @override
  Future<ProfileModel> getMe() async {
    String baseUrl = dotenv.env['BASE_URL']!;
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    final uri = Uri.parse('${baseUrl}profile/user');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    log('GET Request: $uri', name: 'ProfileRemoteDataSourceImpl.getMe');
    log('Headers: $headers', name: 'ProfileRemoteDataSourceImpl.getMe');

    try {
      final response = await client.get(uri, headers: headers);

      log('Response Status Code: ${response.statusCode}',
          name: 'ProfileRemoteDataSourceImpl.getMe');
      log('Response Body: ${response.body}',
          name: 'ProfileRemoteDataSourceImpl.getMe');

      if (response.statusCode == 200) {
        final person = json.decode(response.body)['data'];
        return ProfileModel.fromJson(person);
      } else {
        log('Error: ServerException occurred',
            name: 'ProfileRemoteDataSourceImpl.getMe', error: response.body);
        throw ServerException();
      }
    } catch (e) {
      log('Error during getMe: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<String?> updateMe(ProfileModel profile) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    final uri = Uri.parse('${baseUrl}profile/update');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };
    final body = jsonEncode(Utils.getNotNullFields(profile.toJson()));

    log('PUT Request: $uri', name: 'ProfileRemoteDataSourceImpl.updateMe');
    log('Headers: $headers', name: 'ProfileRemoteDataSourceImpl.updateMe');
    log('Request Body: $body', name: 'ProfileRemoteDataSourceImpl.updateMe');

    try {
      final response = await client.put(uri, headers: headers, body: body);

      log('Response Status Code: ${response.statusCode}',
          name: 'ProfileRemoteDataSourceImpl.updateMe');
      log('Response Body: ${response.body}',
          name: 'ProfileRemoteDataSourceImpl.updateMe');

      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return data['data']['code'];
        case 409:
          final data = json.decode(response.body);
          final error = data['data']['error'];
          if (error.toString().contains('SMS')) {
            return data['data']['code'].toString();
          } else if (error.toString().contains('СМС')) {
            return 'null';
            throw SendingCodeTooOftenException();
          }
          log('Error: AcceptPersonalDataException occurred',
              name: 'ProfileRemoteDataSourceImpl.updateMe',
              error: response.body);
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
    String baseUrl = dotenv.env['BASE_URL']!;
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    final uri = Uri.parse('${baseUrl}profile/delete');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    log('GET Request: $uri', name: 'ProfileRemoteDataSourceImpl.deleteMe');
    log('Headers: $headers', name: 'ProfileRemoteDataSourceImpl.deleteMe');

    try {
      final response = await client.delete(uri, headers: headers);

      log('Response Status Code: ${response.statusCode}',
          name: 'ProfileRemoteDataSourceImpl.deleteMe');
      log('Response Body: ${response.body}',
          name: 'ProfileRemoteDataSourceImpl.deleteMe');

      if (response.statusCode != 200) {
        log('Error: ServerException occurred',
            name: 'ProfileRemoteDataSourceImpl.deleteMe', error: response.body);
        throw ServerException();
      } else {
        // очищаем токен
        sharedPreferences.remove(SharedPreferencesKeys.accessToken);
      }
    } catch (e) {
      log('Error during deleteMe: $e', level: 1000);
      rethrow;
    }
  }
}
