import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/region_entity.dart';
import 'package:nevis/features/domain/repositories/region_repository.dart';

class GetRegionsUC extends UseCase<List<RegionEntity>> {
  final RegionRepository regionRepository;
  GetRegionsUC(this.regionRepository);

  @override
  Future<Either<Failure, List<RegionEntity>>> call() async {
    return await regionRepository.getRegions();
  }
}
