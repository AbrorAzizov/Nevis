import 'package:dartz/dartz.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/repositories/main_repository.dart';

import '../../../../core/error/failure.dart';

class GetPopularProductsUC extends UseCase<List<ProductEntity>> {
  final MainRepository mainRepository;

  GetPopularProductsUC(this.mainRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await mainRepository.getPopularProducts();
  }
}