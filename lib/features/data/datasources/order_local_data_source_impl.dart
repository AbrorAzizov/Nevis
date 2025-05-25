import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:nevis/features/data/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderModel>> getOrderHistory();
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final SharedPreferences sharedPreferences;

  OrderLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<List<OrderModel>> getOrderHistory() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/response.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final List<dynamic> data = jsonMap['data'];
      final List<OrderModel> orders =
          data.map((e) => OrderModel.fromJson(e)).toList();
      return orders;
    } catch (e) {
      log('Error during getOrderHistory: $e', level: 1000);
      rethrow;
    }
  }
}
