import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/profile_remote_data_source_impl.dart';
import 'package:nevis/features/data/models/adress_model.dart';
import 'package:nevis/features/data/models/profile_model.dart';
import 'package:nevis/features/domain/entities/adress_entity.dart';
import 'package:nevis/features/domain/entities/profile_entity.dart';
import 'package:nevis/features/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  const ProfileRepositoryImpl({
    required this.profileRemoteDataSource,
    required this.networkInfo,
    required this.errorHandler,
  });

  // 📌 Получения данных профиля
  @override
  Future<Either<Failure, ProfileEntity>> getMe() async =>
      await errorHandler.handle(
        () async => await profileRemoteDataSource.getMe(),
      );

  // 📌 Обновление данных профиля
  @override
  Future<Either<Failure, void>> updateMe(ProfileModel profile) async =>
      await errorHandler.handle(
        () async => await profileRemoteDataSource.updateMe(profile),
      );

  // 📌 Удаление профиля
  @override
  Future<Either<Failure, void>> deleteMe() async => await errorHandler.handle(
        () async => await profileRemoteDataSource.deleteMe(),
      );

  @override
  Future<Either<Failure, AddressEntity>> getDeliveryAdress() async => await errorHandler.handle(
        () async => await profileRemoteDataSource.getDeliveryAdress(),
      );

  @override
  Future<Either<Failure, void>> updayteDeliveryAdress(AdressModel adress) async =>
      await errorHandler.handle(
        () async => await profileRemoteDataSource.updateDeliveryAdress(adress),
      );
}
