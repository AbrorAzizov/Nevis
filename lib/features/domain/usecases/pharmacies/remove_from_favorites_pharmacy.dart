import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/pharmacy_repository.dart';

class RemoveFromFavoritesPharmacyUC extends UseCaseParam<void, int> {
  final PharmacyRepository pharmacyRepository;
  RemoveFromFavoritesPharmacyUC(this.pharmacyRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await pharmacyRepository.removeFromFavoritesPharmacy(params);
  }
}
