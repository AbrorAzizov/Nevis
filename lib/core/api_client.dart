import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/domain/usecases/auth/refresh_token.dart';
import 'package:nevis/locator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final String baseUrl = dotenv.env['BASE_URL']!;

  ApiClient({required this.client, required this.sharedPreferences});

  Future<dynamic> _handleResponseWithRetry(
    Future<http.Response> Function() request,
    Map<int, ApiException>? exceptions,
    String? callPathNameForLog,
  ) async {
    http.Response response = await request();

    if (response.statusCode == 401 || response.statusCode == 403) {
      log('🔁 Token expired. Trying to refresh...',
          name: callPathNameForLog ?? '');
      try {
        // рефреш токена
        RefreshTokenUC refreshTokenUC = sl<RefreshTokenUC>();
        await refreshTokenUC();

        // Повторяем запрос
        response = await request();
      } catch (_) {
        throw UnauthorizedException(); // не смогли обновить токен
      }
    }

    return _handleResponse(response, exceptions, callPathNameForLog);
  }

  dynamic _handleResponse(
    http.Response response,
    Map<int, ApiException>? exceptions,
    String? callPathNameForLog,
  ) {
    final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    final message = responseBody is Map<String, dynamic> &&
            responseBody['message'] is String
        ? responseBody['message'] as String
        : 'Неизвестная ошибка';

    log('Response (${response.request?.url}): ${response.statusCode} $responseBody',
        name: callPathNameForLog ?? 'NoCallPathNameForLog');

    if (exceptions != null && exceptions.containsKey(response.statusCode)) {
      throw exceptions[response.statusCode]?.copyWith(message: message) ??
          ServerException(message);
    }

    return responseBody;
  }

  Future<dynamic> get({
    required String endpoint,
    Map<int, ApiException>? exceptions,
    String? callPathNameForLog,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _authHeaders();

    return _handleResponseWithRetry(
      () => client.get(url, headers: headers),
      exceptions,
      callPathNameForLog,
    );
  }

  Future<dynamic> post({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<int, ApiException>? exceptions,
    String? callPathNameForLog,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _authHeaders();
    final bodyString = jsonEncode(body);

    return _handleResponseWithRetry(
      () => client.post(url, headers: headers, body: bodyString),
      exceptions,
      callPathNameForLog,
    );
  }

  Future<dynamic> put({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<int, ApiException>? exceptions,
    String? callPathNameForLog,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _authHeaders();
    final bodyString = jsonEncode(body);

    return _handleResponseWithRetry(
      () => client.put(url, headers: headers, body: bodyString),
      exceptions,
      callPathNameForLog,
    );
  }

  Future<dynamic> delete({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<int, ApiException>? exceptions,
    String? callPathNameForLog,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _authHeaders();
    final bodyString = jsonEncode(body);

    return _handleResponseWithRetry(
      () => client.delete(url, headers: headers, body: bodyString),
      exceptions,
      callPathNameForLog,
    );
  }

  Future<Map<String, String>> _authHeaders() async {
    final accessToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
  }
}
