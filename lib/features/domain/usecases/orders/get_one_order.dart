import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/repositories/order_repository.dart';


class GetOneOrderUC extends UseCaseParam<OrderEntity?, int> {
  final OrderRepository orderRepository;

  GetOneOrderUC(this.orderRepository);

  @override
  Future<Either<Failure, OrderEntity?>> call(int params) async {
    return await orderRepository.getOrderById(params);
  }
}
