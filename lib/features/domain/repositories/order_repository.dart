import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';


abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrderHistory();
  Future<Either<Failure, OrderEntity?>> getOrderById(int id);
}
