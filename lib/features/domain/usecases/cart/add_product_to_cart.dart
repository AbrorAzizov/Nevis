import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/cart_repository.dart';

class AddProductToCartUC extends UseCaseParam<void, CartParams> {
  final CartRepository cartRepository;

  AddProductToCartUC(this.cartRepository);

  @override
  Future<Either<Failure, void>> call(CartParams params) async {
    return await cartRepository.addProductToCart(params);
  }
}
