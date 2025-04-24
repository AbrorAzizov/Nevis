import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class UpdateFavoriteProductsUC extends UseCaseParam<void, int> {
  final ProductRepository productRepository;

  UpdateFavoriteProductsUC(this.productRepository);

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await productRepository.updateFavoriteProducts(params);
  }
}
