import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/category_params.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/search_products_entity.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class GetSortCategoryProductsUC
    extends UseCaseParam<SearchProductsEntity, CategoryParams> {
  final ProductRepository productRepository;

  GetSortCategoryProductsUC(this.productRepository);

  @override
  Future<Either<Failure, SearchProductsEntity>> call(
      CategoryParams params) async {
    return await productRepository.getSortCategoryProducts(params);
  }
}
