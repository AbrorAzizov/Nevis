import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nevis/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final String baseUrl = dotenv.env['BASE_URL']!;

  ApiClient({required this.client, required this.sharedPreferences});

  // Общий метод для обработки ответа
  dynamic _handleResponse(http.Response response,
      Map<int, Exception>? exceptions, String? callPathNameForLog) {
    final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    log('Response (${response.request?.url}): ${response.statusCode} $responseBody',
        name: callPathNameForLog ?? 'NoCallPathNameForLog');

    if (exceptions != null && exceptions.containsKey(response.statusCode)) {
      throw exceptions[response.statusCode] ?? ServerException();
    }

    return responseBody;
  }

  Future<dynamic> post(
      {required String endpoint,
      Map<String, dynamic>? body,
      Map<int, Exception>? exceptions,
      String? callPathNameForLog}) async {
    final serverToken = sharedPreferences.getString('accessToken');
    final url = Uri.parse('$baseUrl$endpoint');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    final bodyString = jsonEncode(body);

    log('POST $url', name: callPathNameForLog ?? 'NoCallPathNameForLog');
    log('Request body: $bodyString',
        name: callPathNameForLog ?? 'NoCallPathNameForLog');

    try {
      final response =
          await client.post(url, headers: headers, body: bodyString);
      return _handleResponse(response, exceptions, callPathNameForLog);
    } catch (e) {
      log('Error during POST request to $url: $e',
          name: callPathNameForLog ?? 'NoCallPathNameForLog', level: 1000);
      rethrow;
    }
  }

  Future<dynamic> get(
      {required String endpoint,
      Map<int, Exception>? exceptions,
      String? callPathNameForLog}) async {
    final serverToken = sharedPreferences.getString('accessToken');
    final url = Uri.parse('$baseUrl$endpoint');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    log('GET $url', name: callPathNameForLog ?? 'NoCallPathNameForLog');

    try {
      final response = await client.get(url, headers: headers);
      return _handleResponse(response, exceptions, callPathNameForLog);
    } catch (e) {
      log('Error during GET request to $url: $e',
          name: callPathNameForLog ?? 'NoCallPathNameForLog', level: 1000);
      rethrow;
    }
  }

  Future<dynamic> delete(
      {required String endpoint,
      Map<String, dynamic>? body,
      Map<int, Exception>? exceptions,
      String? callPathNameForLog}) async {
    final serverToken = sharedPreferences.getString('accessToken');
    final url = Uri.parse('$baseUrl$endpoint');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    final bodyString = jsonEncode(body);

    log('DELETE $url', name: callPathNameForLog ?? 'NoCallPathNameForLog');
    log('Request body: $bodyString',
        name: callPathNameForLog ?? 'NoCallPathNameForLog');

    try {
      final response =
          await client.delete(url, headers: headers, body: bodyString);
      return _handleResponse(response, exceptions, callPathNameForLog);
    } catch (e) {
      log('Error during DELETE request to $url: $e',
          name: callPathNameForLog ?? 'NoCallPathNameForLog', level: 1000);
      rethrow;
    }
  }

  Future<dynamic> put(
      {required String endpoint,
      Map<String, dynamic>? body,
      Map<int, Exception>? exceptions,
      String? callPathNameForLog}) async {
    final serverToken = sharedPreferences.getString('accessToken');
    final url = Uri.parse('$baseUrl$endpoint');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    final bodyString = jsonEncode(body);

    log('PUT $url', name: callPathNameForLog ?? 'NoCallPathNameForLog');
    log('Request body: $bodyString',
        name: callPathNameForLog ?? 'NoCallPathNameForLog');

    try {
      final response =
          await client.put(url, headers: headers, body: bodyString);
      return _handleResponse(response, exceptions, callPathNameForLog);
    } catch (e) {
      log('Error during PUT request to $url: $e',
          name: callPathNameForLog ?? 'NoCallPathNameForLog', level: 1000);
      rethrow;
    }
  }
}
