import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class UpdateFavoriteProductsUC extends UseCaseParam<void, ProductEntity> {
  final ProductRepository productRepository;

  UpdateFavoriteProductsUC(this.productRepository);

  @override
  Future<Either<Failure, void>> call(ProductEntity params) async {
    return await productRepository.updateFavoriteProducts(params);
  }
}

class UpdateSeveralFavoriteProductsUC extends UseCaseParam<void, List<int>> {
  final ProductRepository productRepository;

  UpdateSeveralFavoriteProductsUC(this.productRepository);

  @override
  Future<Either<Failure, void>> call(List<int> params) async {
    return await productRepository.syncFavoriteProductsFromLocal(params);
  }
}
