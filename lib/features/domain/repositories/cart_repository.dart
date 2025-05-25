import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCartProducts();
  Future<Either<Failure, void>> addProductToCart(CartParams product);
}
