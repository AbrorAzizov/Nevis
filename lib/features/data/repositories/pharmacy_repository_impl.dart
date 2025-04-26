import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/pharmacy_remote_data_soruce_impl.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/domain/repositories/pharmacy_repository.dart';

class PharmacyRepositoryImpl extends PharmacyRepository {
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;
  final PharmacyRemoteDataSource pharmacyRemoteDataSource;

  PharmacyRepositoryImpl(
      {required this.networkInfo,
      required this.errorHandler,
      required this.pharmacyRemoteDataSource});

  @override
  Future<Either<Failure, List<PharmacyEntity>>> getFavoritePharmacies() async =>
      await errorHandler.handle(
          () async => await pharmacyRemoteDataSource.getFavoritePharmacies());
}
