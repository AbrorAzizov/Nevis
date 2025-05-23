import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/repositories/order_repository.dart';

class GetPharmaciesByCartUC
    extends UseCaseParam<List<PharmacyEntity>, List<CartParams>> {
  final OrderRepository orderRepository;

  GetPharmaciesByCartUC(this.orderRepository);
  @override
  Future<Either<Failure, List<PharmacyEntity>>> call(
      List<CartParams> params) async {
    return await orderRepository.getAvialablePharmacies(params);
  }
}
