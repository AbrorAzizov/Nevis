import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/bargain_product_params.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/bargain_product_entity.dart';
import 'package:nevis/features/domain/repositories/product_repository.dart';

class GetBargainProductUC extends UseCaseParam<void, BargainProductParams> {
  final ProductRepository repository;
  GetBargainProductUC(this.repository);

  @override
  Future<Either<Failure, BargainProductEntity>> call(
      BargainProductParams params) {
    return repository.getBargainProduct(params);
  }
}
