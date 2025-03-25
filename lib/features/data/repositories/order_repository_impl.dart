import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/order_remote_data_source_impl.dart';
import 'package:nevis/features/data/models/order_model.dart';
import 'package:nevis/features/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  const OrderRepositoryImpl({
    required this.orderRemoteDataSource,
    required this.networkInfo,
    required this.errorHandler,
  });

  // 📌 Получение списка заказов
  @override
  Future<Either<Failure, List<OrderModel>>> getOrderHistory() async =>
      await errorHandler.handle(
        () async => await orderRemoteDataSource.getOrderHistory(),
      );

  // 📌 Получение заказа по ID
  @override
  Future<Either<Failure, OrderModel?>> getOrderById(int id) async =>
      await errorHandler.handle(
        () async => await orderRemoteDataSource.getOrderById(id),
      );
}