import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/region_repository.dart';

class SelectRegionUC extends UseCaseParam<void, int> {
  final RegionRepository regionRepository;
  SelectRegionUC(this.regionRepository);

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await regionRepository.selectRegion(params);
  }
}
