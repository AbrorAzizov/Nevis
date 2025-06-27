import 'dart:developer';

import 'package:nevis/constants/enums.dart';
import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/core/params/delivery_order_params.dart';
import 'package:nevis/features/data/models/delivery_order_model.dart';
import 'package:nevis/features/data/models/order_model.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrderHistory();
  Future<OrderModel?> getOrderById(int id);
  Future<List<PharmacyModel>> getAvialablePharmacies(List<CartParams> cart);
  Future<List<OrderModel>> createOrderForPickup(List<CartParams> cart);
  Future<DeliveryOrderModel> createOrderForDelivery(DeliveryOrderParams params);
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
          exceptions: {400: EmptyOrdersException()});

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
      );

      List<dynamic> dataList = data['STORES'];
      return dataList.map((e) => PharmacyModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getAvialablePharmacies: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<OrderModel>> createOrderForPickup(List<CartParams> cart) async {
    final body = cart.map((e) => e.toJsonForOrder()).toList();
    try {
      final data = await apiClient.post(
        body: {'items': body},
        endpoint: 'orders/create',
        exceptions: {500: ServerException()},
        callPathNameForLog: '${runtimeType.toString()}.createOrderForPickup',
      );

      final ordersMap =
          data['success']['orders'] as Map<String, dynamic>? ?? {};
      final available = (ordersMap['available'] as List<dynamic>? ?? []);
      final availableOnRequest =
          (ordersMap['available_on_request'] as List<dynamic>? ?? []);

      final allOrders = [...available, ...availableOnRequest];

      return allOrders.map((e) {
        return OrderModel.fromJson(e,
            status: available.isEmpty
                ? AvailabilityCartStatus.fromWareHouse
                : AvailabilityCartStatus.available);
      }).toList();
    } catch (e) {
      log(
        'Error during createOrderForPickup: $e',
        level: 1000,
        name: '${runtimeType.toString()}.createOrderForPickup',
      );
      rethrow;
    }
  }

  @override
  Future<DeliveryOrderModel> createOrderForDelivery(
      DeliveryOrderParams params) async {
    try {
      final data = await apiClient.post(
        body: params.toJson(),
        endpoint: 'orders/create',
        exceptions: {500: ServerException()},
        callPathNameForLog: '${runtimeType.toString()}.createOrderForDelivery',
      );

      return DeliveryOrderModel.fromJson(data);
    } catch (e) {
      log(
        'Error during createOrderForDelivery: $e',
        level: 1000,
        name: '${runtimeType.toString()}.createOrderForDelivery',
      );
      rethrow;
    }
  }
}
