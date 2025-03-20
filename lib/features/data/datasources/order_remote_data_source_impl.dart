import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart'; // remove it
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/data/models/order_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrderHistory();
  Future<OrderModel?> getOrderById(int id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  OrderRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<List<OrderModel>> getOrderHistory() async {
    String baseUrl = dotenv.env['BASE_URL']!;
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    final uri = Uri.parse('${baseUrl}order/history');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    log('GET Request: $uri', name: 'OrderRemoteDataSource.getOrderHistory');
    log('Headers: $headers', name: 'OrderRemoteDataSource.getOrderHistory');

    try {
      final response = await client.get(uri, headers: headers);

      log('Response Status Code: ${response.statusCode}',
          name: 'OrderRemoteDataSource.getOrderHistory');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> dataList = data['data'];

        return dataList.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error during getOrderHistory: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<OrderModel?> getOrderById(int id) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    final uri = Uri.parse('${baseUrl}order/details/$id');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $serverToken'
    };

    log('GET Request: $uri', name: 'OrderRemoteDataSource.getOrderById');
    log('Headers: $headers', name: 'OrderRemoteDataSource.getOrderById');

    try {
      final response = await client.get(uri, headers: headers);

      log('Response Status Code: ${response.statusCode}',
          name: 'OrderRemoteDataSource.getOrderById');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['data'] != null) {
          return OrderModel.fromJson(data['data'].first);
        }
        return null;
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error during getOrderById: $e', level: 1000);
      rethrow;
    }
  }
}

class MockOrderRemoteDataSource implements OrderRemoteDataSource{
   final http.Client client;
  final SharedPreferences sharedPreferences;

  MockOrderRemoteDataSource({required this.client, required this.sharedPreferences});
  @override
  Future<List<OrderModel>> getOrderHistory() async {
    await Future.delayed(Duration (milliseconds: 500)); 
    final jsonString = await rootBundle.loadString('assets/response.json');
    final data = jsonDecode(jsonString);
    List<dynamic> dataList = data['data'];

   return dataList.map((e) => OrderModel.fromJson(e)).toList();
  }
  @override
 Future<OrderModel?> getOrderById(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final jsonString = await rootBundle.loadString('assets/response.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);
    if (data.containsKey('data') && data['data'] is List) {
      final List<dynamic> orders = data['data'];
      final orderData = orders.firstWhere(
        (order) => order['order_id'] == id,
        orElse: () => null, 
      );
      if (orderData != null) {
        return OrderModel.fromJson(orderData);
      }
    }
    return null;
  }
}
