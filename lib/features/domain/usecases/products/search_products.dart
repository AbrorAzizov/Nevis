import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/product_param.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class SearchProductsUC extends UseCaseParam<List<ProductEntity>, ProductParam> {
  final ProductRepository productRepository;

  SearchProductsUC(this.productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(ProductParam params) async {
    return await productRepository.searchProducts(params);
  }
}
