import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_for_selected_pharmacy_param.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/features/domain/entities/cart_entity.dart';
import 'package:nevis/features/domain/entities/order_cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCartProducts();
  Future<Either<Failure, void>> addProductToCart(CartParams product);
  Future<Either<Failure, void>> deleteProductFromCart(int productId);
  Future<Either<Failure, OrderCartEntity>> getCartForSelectedPharmacyProducts(
      CartForSelectedPharmacyParam cart);
}
