import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/repositories/order_repository.dart';

class GetOrderHistoryUC extends UseCase<List<OrderEntity>> {
  final OrderRepository orderRepository;

  GetOrderHistoryUC(this.orderRepository);

  @override
  Future<Either<Failure, List<OrderEntity>>> call() async {
    return await orderRepository.getOrderHistory();
  }
}
