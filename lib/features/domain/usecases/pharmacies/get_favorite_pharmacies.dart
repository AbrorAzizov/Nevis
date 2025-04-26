import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/repositories/pharmacy_repository.dart';

class GetFavoritePharmaciesUC extends UseCase<List<PharmacyEntity>> {
  final PharmacyRepository pharmacyRepository;
  GetFavoritePharmaciesUC(this.pharmacyRepository);
  @override
  Future<Either<Failure, List<PharmacyEntity>>> call() async {
    return await pharmacyRepository.getFavoritePharmacies();
  }
}
