import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/subcategory_params.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/subcategory_entity.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class GetSubCategoriesUC
    extends UseCaseParam<SubcategoryEntity, SubcategoryParams> {
  final ProductRepository productRepository;

  GetSubCategoriesUC(this.productRepository);

  @override
  Future<Either<Failure, SubcategoryEntity>> call(params) async {
    return await productRepository.getSubCategories(params);
  }
}
