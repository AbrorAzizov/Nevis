import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/order_local_data_source_impl.dart';
import 'package:nevis/features/data/datasources/order_remote_data_source_impl.dart';
import 'package:nevis/features/data/models/order_model.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;
  final OrderLocalDataSource orderLocalDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  const OrderRepositoryImpl({
    required this.orderRemoteDataSource,
    required this.networkInfo,
    required this.errorHandler,
    required this.orderLocalDataSource,
  });

  // 📌 Получение списка заказов
  @override
  Future<Either<Failure, List<OrderModel>>> getOrderHistory() async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      return await errorHandler.handle(() async {
        return await orderRemoteDataSource.getOrderHistory();
      });
    } else {
      return await errorHandler.handle(() async {
        return await orderLocalDataSource.getOrderHistory();
      });
    }
  }

  // 📌 Получение заказа по ID
  @override
  Future<Either<Failure, OrderModel?>> getOrderById(int id) async =>
      await errorHandler.handle(
        () async => await orderRemoteDataSource.getOrderById(id),
      );

  @override
  Future<Either<Failure, List<PharmacyEntity>>> getAvialablePharmacies(
          List<CartParams> cart) async =>
      await errorHandler.handle(
        () async => await orderRemoteDataSource.getAvialablePharmacies(cart),
      );

  @override
  Future<Either<Failure, List<OrderEntity>>> createOrderForPickup(
          List<CartParams> cart) async =>
      await errorHandler.handle(
        () async => await orderRemoteDataSource.createOrderForPickup(cart),
      );
}
