import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_for_selected_pharmacy_param.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/cart_remote_data_source_implementation.dart';
import 'package:nevis/features/domain/entities/cart_entity.dart';
import 'package:nevis/features/domain/entities/order_cart_entity.dart';
import 'package:nevis/features/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepositoryImpl(
      {required this.networkInfo,
      required this.errorHandler,
      required this.cartRemoteDataSource});
  @override
  Future<Either<Failure, CartEntity>> getCartProducts() async =>
      await errorHandler
          .handle(() async => await cartRemoteDataSource.getCartProducts());

  @override
  Future<Either<Failure, void>> addProductToCart(CartParams product) async =>
      await errorHandler.handle(
          () async => await cartRemoteDataSource.addProductToCart(product));

  @override
  Future<Either<Failure, void>> deleteProductFromCart(int productId) async =>
      await errorHandler.handle(() async =>
          await cartRemoteDataSource.deleteProductFromCart(productId));

  @override
  Future<Either<Failure, OrderCartEntity>> getCartForSelectedPharmacyProducts(
          CartForSelectedPharmacyParam cart) async =>
      await errorHandler.handle(() async =>
          await cartRemoteDataSource.getProductsForSelectedPharmacy(cart));
}
