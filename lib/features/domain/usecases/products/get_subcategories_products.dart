import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class GetSubCategoriesUC extends UseCaseParam<List<CategoryEntity>, int> {
  final ProductRepository productRepository;

  GetSubCategoriesUC(this.productRepository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(params) async {
    return await productRepository.getSubCategories(params);
  }
}
