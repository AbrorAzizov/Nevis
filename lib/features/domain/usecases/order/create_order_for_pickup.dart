import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/repositories/order_repository.dart';

class CreateOrderForPickupUC
    extends UseCaseParam<List<OrderEntity>, List<CartParams>> {
  final OrderRepository orderRepository;

  CreateOrderForPickupUC(this.orderRepository);
  @override
  Future<Either<Failure, List<OrderEntity>>> call(params) async {
    return await orderRepository.createOrderForPickup(params);
  }
}
