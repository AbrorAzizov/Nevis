import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';

import '../../../../constants/enums.dart';
import '../../entities/product_entity.dart';
import '../../repositories/product_repository.dart';

class ProductsCompilationUC extends UseCaseParam <(List<ProductEntity>, int lastPage), ProductsCompilationType>{
  final ProductRepository productRepository;

  ProductsCompilationUC(this.productRepository);

  @override
  Future<Either<Failure, (List<ProductEntity>, int lastPage)>> call(ProductsCompilationType productsCompilationType,
      {int? page}) async {
    return await productRepository.productsCompilation(productsCompilationType: productsCompilationType, page: page);
  }
}