import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/cart_repository.dart';

class DeleteProductFromCartUC extends UseCaseParam<void, int> {
  final CartRepository cartRepository;

  DeleteProductFromCartUC(this.cartRepository);

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await cartRepository.deleteProductFromCart(params);
  }
}
