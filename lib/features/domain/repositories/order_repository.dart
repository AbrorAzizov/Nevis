import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_params.dart';
<<<<<<< HEAD
=======
import 'package:nevis/core/params/delivery_order_params.dart';
import 'package:nevis/features/domain/entities/delivery_order_entity.dart';
>>>>>>> main
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrderHistory();
  Future<Either<Failure, OrderEntity?>> getOrderById(int id);
  Future<Either<Failure, List<PharmacyEntity>>> getAvialablePharmacies(
      List<CartParams> cart);
  Future<Either<Failure, List<OrderEntity>>> createOrderForPickup(
      List<CartParams> cart);
<<<<<<< HEAD
=======
  Future<Either<Failure, DeliveryOrderEntity>> createOrderForDelivery(
      DeliveryOrderParams params);
>>>>>>> main
}
