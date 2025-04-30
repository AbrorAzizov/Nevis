import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/region_remote_soruce.dart';
import 'package:nevis/features/domain/entities/region_entity.dart';
import 'package:nevis/features/domain/repositories/region_repository.dart';

class RegionRespositoryImpl extends RegionRepository {
  final RegionRemoteDataSource regionRemoteDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  RegionRespositoryImpl(
      {required this.regionRemoteDataSource,
      required this.networkInfo,
      required this.errorHandler});

  @override
  Future<Either<Failure, List<RegionEntity>>> getRegions() async =>
      await errorHandler.handle(
        () async => await regionRemoteDataSource.getRegions(),
      );

  @override
  Future<Either<Failure, void>> selectRegion(int id) async => await errorHandler
      .handle(() async => await regionRemoteDataSource.selectRegion(id));
}
