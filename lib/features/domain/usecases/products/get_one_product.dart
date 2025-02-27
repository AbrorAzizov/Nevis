import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';


class GetOneProductUC extends UseCaseParam<ProductEntity?, int> {
  final ProductRepository productRepository;

  GetOneProductUC(this.productRepository);

  @override
  Future<Either<Failure, ProductEntity?>> call(int params) async {
    return await productRepository.getProductById(params);
  }
}
