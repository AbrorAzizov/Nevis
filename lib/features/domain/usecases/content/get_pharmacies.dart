import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/repositories/content_repository.dart';


class GetPharmaciesUC extends UseCaseParam<List<PharmacyEntity>, String> {
  final ContentRepository contentRepository;

  GetPharmaciesUC(this.contentRepository);

  @override
  Future<Either<Failure, List<PharmacyEntity>>> call(String params) async {
    return await contentRepository.getPharmacies(params);
  }
}
