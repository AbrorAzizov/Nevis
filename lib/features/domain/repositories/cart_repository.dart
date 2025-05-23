import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<ProductEntity>>> getCartProducts();
  Future<Either<Failure, void>> addProductToCart(CartParams product);
}
