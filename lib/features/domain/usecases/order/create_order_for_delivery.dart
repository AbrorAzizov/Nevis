import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/delivery_order_params.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/delivery_order_entity.dart';
import 'package:nevis/features/domain/repositories/order_repository.dart';

class CreateOrderForDeliveryUC
    extends UseCaseParam<DeliveryOrderEntity, DeliveryOrderParams> {
  final OrderRepository orderRepository;

  CreateOrderForDeliveryUC(this.orderRepository);
  @override
  Future<Either<Failure, DeliveryOrderEntity>> call(params) async {
    return await orderRepository.createOrderForDelivery(params);
  }
}
