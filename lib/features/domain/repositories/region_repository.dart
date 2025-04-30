import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/features/domain/entities/region_entity.dart';

abstract class RegionRepository {
  Future<Either<Failure, List<RegionEntity>>> getRegions();
  Future<Either<Failure, void>> selectRegion(int id);
}
