import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class GetFavoriteProductsUC extends UseCase<List<ProductEntity>> {
  final ProductRepository productRepository;

  GetFavoriteProductsUC(this.productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await productRepository.getFavoriteProducts();
  }
}
