import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_for_selected_pharmacy_param.dart';
import 'package:nevis/core/params/cart_params.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/data/datasources/cart_local_data_source_impl.dart';
import 'package:nevis/features/data/datasources/cart_remote_data_source_implementation.dart';
import 'package:nevis/features/domain/entities/cart_entity.dart';
import 'package:nevis/features/domain/entities/order_cart_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/repositories/cart_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepositoryImpl extends CartRepository {
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;
  final CartRemoteDataSource cartRemoteDataSource;
  final CartLocalDataSource cartLocalDataSource;
  final SharedPreferences sharedPreferences;

  CartRepositoryImpl({
    required this.networkInfo,
    required this.errorHandler,
    required this.cartLocalDataSource,
    required this.cartRemoteDataSource,
    required this.sharedPreferences,
  });

  bool get _isAuthorized =>
      sharedPreferences.getString(SharedPreferencesKeys.accessToken) != null;

  @override
  Future<Either<Failure, CartEntity>> getCartProducts() async {
    if (_isAuthorized) {
      final localCart = await cartLocalDataSource.getCartProducts();
      if (localCart.cartItems.isNotEmpty) {
        await syncCartFromLocal(localCart.cartItems);
      }

      return await errorHandler.handle(
        () async => await cartRemoteDataSource.getCartProducts(),
      );
    } else {
      return await errorHandler.handle(
        () async => await cartLocalDataSource.getCartProducts(),
      );
    }
  }

  @override
  Future<Either<Failure, void>> addProductToCart(CartParams params) async {
    if (_isAuthorized) {
      return await errorHandler.handle(
        () async => await cartRemoteDataSource.addProductToCart(params),
      );
    } else {
      return await errorHandler.handle(() async {
        if (params.product == null) {
          throw ServerException('ProductEntity is required for local cart');
        }
        return await cartLocalDataSource.addProductToCart(params.product!);
      });
    }
  }

  @override
  Future<Either<Failure, void>> deleteProductFromCart(int productId) async {
    if (_isAuthorized) {
      return await errorHandler.handle(
        () async => await cartRemoteDataSource.deleteProductFromCart(productId),
      );
    } else {
      return await errorHandler.handle(() async {
        return await cartLocalDataSource.deleteProductFromCart(productId);
      });
    }
  }

  @override
  Future<Either<Failure, OrderCartEntity>> getCartForSelectedPharmacyProducts(
      CartForSelectedPharmacyParam cart) async {
    return await errorHandler.handle(() async =>
        await cartRemoteDataSource.getProductsForSelectedPharmacy(cart));
  }

  Future<Either<Failure, void>> clearLocalCart() async {
    return await errorHandler.handle(
      () async => await cartLocalDataSource.clearLocalCart(),
    );
  }

  @override
  Future<Either<Failure, void>> syncCartFromLocal(
      List<ProductEntity> products) async {
    if (!_isAuthorized) {
      return const Right(null);
    }
    return await errorHandler.handle(() async {
      for (final product in products) {
        final count = product.count ?? 1;
        if (product.productId != null) {
          await cartRemoteDataSource.addProductToCart(
            CartParams(
              id: product.productId!,
              quantity: count,
              product: product,
            ),
          );
        }
      }
      await cartLocalDataSource.clearLocalCart();
    });
  }
}
