import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nevis/core/api_client.dart';
import 'package:nevis/features/data/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrderHistory();
  Future<OrderModel?> getOrderById(int id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  OrderRemoteDataSourceImpl({
    required this.apiClient,
    required this.sharedPreferences,
  });

  //@override
  //Future<List<OrderModel>> getOrderHistory() async {
  //  try {
  //    final data = await apiClient.get(
  //      endpoint: 'order/history',
  //      callPathNameForLog: '${runtimeType.toString()}.getOrderHistory',
  //    );
//
  //    List<dynamic> dataList = data['data'];
  //    return dataList.map((e) => OrderModel.fromJson(e)).toList();
  //  } catch (e) {
  //    log('Error during getOrderHistory: $e', level: 1000);
  //    rethrow;
  //  }
  //}
//
  //@override
  //Future<OrderModel?> getOrderById(int id) async {
  //  try {
  //    final data = await apiClient.get(
  //      endpoint: 'order/details/$id',
  //      callPathNameForLog: '${runtimeType.toString()}.getOrderById',
  //    );
//
  //    if (data['data'] != null) {
  //      return OrderModel.fromJson(data['data'].first);
  //    }
  //    return null;
  //  } catch (e) {
  //    log('Error during getOrderById: $e', level: 1000);
  //    rethrow;
  //  }
  //}

  @override
  Future<List<OrderModel>> getOrderHistory() async {
    await Future.delayed(Duration(milliseconds: 500));
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
