import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/cart_entity.dart';
import 'package:nevis/features/domain/repositories/cart_repository.dart';

class GetCartProductsUC extends UseCase<CartEntity> {
  final CartRepository cartRepository;

  GetCartProductsUC(this.cartRepository);

  @override
  Future<Either<Failure, CartEntity>> call() async {
    return await cartRepository.getCartProducts();
  }
}
