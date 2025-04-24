import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class DeleteProductFromFavoriteProductsUC extends UseCaseParam<void, int> {
  final ProductRepository productRepository;

  DeleteProductFromFavoriteProductsUC(this.productRepository);

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await productRepository.deleteFromFavoriteProducts(params);
  }
}
