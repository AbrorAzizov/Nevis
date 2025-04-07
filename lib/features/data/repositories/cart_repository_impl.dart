import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/cart_remote_data_source_implementation.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
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
  Future<Either<Failure, List<ProductEntity>>> getCartProducts() async =>
      await errorHandler
          .handle(() async => await cartRemoteDataSource.getCartProducts());
}
