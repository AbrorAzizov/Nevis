import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/params/category_params.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class GetSortCategoryProductsUC
    extends UseCaseParam<List<ProductEntity>, CategoryParams> {
  final ProductRepository productRepository;

  GetSortCategoryProductsUC(this.productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      CategoryParams params) async {
    return await productRepository.getSortCategoryProducts(params);
  }
}
