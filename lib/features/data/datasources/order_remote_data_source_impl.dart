import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/data/models/order_model.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrderHistory();
  Future<OrderModel?> getOrderById(int id);
  Future<List<PharmacyModel>> getAvialablePharmacies(List<CartParams> cart);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  OrderRemoteDataSourceImpl({
    required this.apiClient,
    required this.sharedPreferences,
  });

  @override
  Future<List<OrderModel>> getOrderHistory() async {
    try {
      final data = await apiClient.get(
          endpoint: 'orders',
          callPathNameForLog: '${runtimeType.toString()}.getOrderHistory',
          exceptions: {401: ServerException(), 500: ServerException()});

      List<dynamic> dataList = data['data'];
      return dataList.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getOrderHistory: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<OrderModel?> getOrderById(int id) async {
    try {
      final data = await apiClient.get(
        endpoint: 'order/details/$id',
        callPathNameForLog: '${runtimeType.toString()}.getOrderById',
      );

      if (data['data'] != null) {
        return OrderModel.fromJson(data['data'].first);
      }
      return null;
    } catch (e) {
      log('Error during getOrderById: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<PharmacyModel>> getAvialablePharmacies(
      List<CartParams> cart) async {
    final body = cart.map((e) => e.toJsonForCartPharmacies()).toList();
    try {
      final data = await apiClient.post(
        body: body,
        endpoint: 'orders/cart',
        exceptions: {
          500: ServerException(),
        },
        callPathNameForLog: '${runtimeType.toString()}.getAvialablePharmacies',
      );

      List<dynamic> dataList = data['STORES'];
      return dataList.map((e) => PharmacyModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getAvialablePharmacies: $e', level: 1000);
      rethrow;
    }
  }
}
