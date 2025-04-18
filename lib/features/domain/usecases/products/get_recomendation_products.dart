import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/search_products_entity.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class GetRecomendationProductsUC
    extends UseCaseParam<SearchProductsEntity, int> {
  final ProductRepository productRepository;

  GetRecomendationProductsUC(this.productRepository);

  @override
  Future<Either<Failure, SearchProductsEntity>> call(int params) async {
    return await productRepository.getRecomendationProducts(params);
  }
}
