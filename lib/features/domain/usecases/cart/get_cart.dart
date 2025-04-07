import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/repositories/cart_repository.dart';

class GetCartProducts extends UseCase<List<ProductEntity>> {
  final CartRepository cartRepository;

  GetCartProducts(this.cartRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await cartRepository.getCartProducts();
  }
}
