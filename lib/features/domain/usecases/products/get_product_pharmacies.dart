import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class GetProductPharmaciesUC
    extends UseCaseParam<List<ProductPharmacyEntity>, int> {
  final ProductRepository productRepository;

  GetProductPharmaciesUC(this.productRepository);

  @override
  Future<Either<Failure, List<ProductPharmacyEntity>>> call(int params) async {
    return await productRepository.getProductPharmacies(params);
  }
}
