import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      {required bool isRetryRequest}) async {
    http.Response response = await request();

    if (response.statusCode == 403 && isRetryRequest) {
      log('🔁 Token expired. Trying to refresh...',
          name: callPathNameForLog ?? '');
      try {
        // Проверяем наличие refresh token
        final refreshToken =
            sharedPreferences.getString(SharedPreferencesKeys.refreshToken);
        if (refreshToken == null || refreshToken.isEmpty) {
          throw UnauthorizedException(); // нет refresh token, не пытаемся рефрешить
        }
        // рефреш токена
        RefreshTokenUC refreshTokenUC = sl<RefreshTokenUC>();
        await refreshTokenUC();

        // Повторяем запрос с новыми заголовками
        final headers = await _authHeaders();
        final originalRequest = response.request!;
        final streamedResponse =
            await client.send(originalRequest..headers.addAll(headers));
        response = await http.Response.fromStream(streamedResponse);
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
    final statusCode = response.statusCode;
    final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    final message = responseBody is Map<String, dynamic>
        ? responseBody['message']?.toString() ??
            responseBody['reasons']?.toString()
        : null;

    if (callPathNameForLog != null) {
      log('Response (${response.request?.url}): $statusCode $responseBody',
          name: callPathNameForLog);
      if (message != null) {
        log('Parsed error message: $message', name: 'ApiClient');
      }
    }

    // ✅ Проверяем наличие поля error в ответе (даже при статусе 200)
    if (responseBody is Map<String, dynamic> &&
        responseBody.containsKey('error')) {
      final errorMessage =
          responseBody['error']?.toString() ?? 'Ошибка без описания';
      log('Found error field in response: $errorMessage', name: 'ApiClient');
      throw ServerException(errorMessage);
    }

    // ✅ Если есть конкретная обработка по статусу
    if (exceptions != null && exceptions.containsKey(statusCode)) {
      final exception = exceptions[statusCode]?.copyWith(message: message) ??
          ServerException(message);
      log('Throwing exception with message: ${exception.message}',
          name: 'ApiClient');
      throw exception;
    }

    // ✅ Бросаем по всем неуспешным кодам (не 2xx)
    if (statusCode < 200 || statusCode >= 300) {
      log('Unexpected status code: $statusCode', name: 'ApiClient');
      throw ServerException(message);
    }

    // ✅ Дополнительно: если сервер возвращает success == false
    if (responseBody is Map<String, dynamic> &&
        responseBody.containsKey('success') &&
        responseBody['success'] == false) {
      throw ServerException(
          responseBody['message']?.toString() ?? 'Ошибка без статуса');
    }

    return responseBody;
  }

  Future<dynamic> get({
    required String endpoint,
    Map<int, ApiException>? exceptions,
    String? callPathNameForLog,
    bool isRetryRequest = true,
    Map<String, dynamic>? queryParameters,
    bool requireAuth = true,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint')
        .replace(queryParameters: queryParameters);
    final headers = await _authHeaders(requireAuth: requireAuth);

    // ✅ Логируем данные запроса
    log('Request URL: $url', name: callPathNameForLog ?? 'Request');
    log('Request Headers: $headers', name: callPathNameForLog ?? 'Request');

    return _handleResponseWithRetry(
        () => client.get(url, headers: headers), exceptions, callPathNameForLog,
        isRetryRequest: isRetryRequest);
  }

  Future<dynamic> post({
    required String endpoint,
    dynamic body,
    Map<int, ApiException>? exceptions,
    String? callPathNameForLog,
    bool isRetryRequest = true,
    Map<String, dynamic>? queryParameters,
    bool requireAuth = true,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint')
        .replace(queryParameters: queryParameters);
    final headers = await _authHeaders(requireAuth: requireAuth);
    final bodyString = jsonEncode(body);

    // ✅ Логируем данные запроса
    log('Request URL: $url', name: callPathNameForLog ?? 'Request');
    log('Request Headers: $headers', name: callPathNameForLog ?? 'Request');
    log('Request Body: $bodyString', name: callPathNameForLog ?? 'Request');

    return _handleResponseWithRetry(
      () => client.post(url, headers: headers, body: bodyString),
      exceptions,
      callPathNameForLog,
      isRetryRequest: isRetryRequest,
    );
  }

  Future<dynamic> put({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<int, ApiException>? exceptions,
    String? callPathNameForLog,
    bool isRetryRequest = true,
    Map<String, dynamic>? queryParameters,
    bool requireAuth = true,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint')
        .replace(queryParameters: queryParameters);
    final headers = await _authHeaders(requireAuth: requireAuth);
    final bodyString = jsonEncode(body);

    // ✅ Логируем данные запроса
    log('Request URL: $url', name: callPathNameForLog ?? 'Request');
    log('Request Headers: $headers', name: callPathNameForLog ?? 'Request');
    log('Request Body: $bodyString', name: callPathNameForLog ?? 'Request');

    return _handleResponseWithRetry(
      () => client.put(url, headers: headers, body: bodyString),
      exceptions,
      callPathNameForLog,
      isRetryRequest: isRetryRequest,
    );
  }

  Future<dynamic> delete({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<int, ApiException>? exceptions,
    String? callPathNameForLog,
    bool isRetryRequest = true,
    Map<String, dynamic>? queryParameters,
    bool requireAuth = true,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint')
        .replace(queryParameters: queryParameters);
    final headers = await _authHeaders(requireAuth: requireAuth);
    final bodyString = jsonEncode(body);

    // ✅ Логируем данные запроса
    log('Request URL: $url', name: callPathNameForLog ?? 'Request');
    log('Request Headers: $headers', name: callPathNameForLog ?? 'Request');
    log('Request Body: $bodyString', name: callPathNameForLog ?? 'Request');

    return _handleResponseWithRetry(
        () => client.delete(url, headers: headers, body: bodyString),
        exceptions,
        callPathNameForLog,
        isRetryRequest: isRetryRequest);
  }

  Future<Map<String, String>> _authHeaders({bool requireAuth = true}) async {
    final accessToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (requireAuth) {
      if (accessToken == null || accessToken.isEmpty) {
        throw UnauthorizedException();
      }
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }
}
