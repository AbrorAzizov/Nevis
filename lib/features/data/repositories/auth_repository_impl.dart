import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/auth_remote_data_source_impl.dart';
import 'package:nevis/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  const AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.networkInfo,
    required this.errorHandler,
  });

  // 📌 Логин
  @override
  Future<Either<Failure, void>> login(String phone, String code) async =>
      await errorHandler.handle(
        () async => await authRemoteDataSource.login(phone, code),
      );

  // 📌 Логаут
  @override
  Future<Either<Failure, void>> logout() async => await errorHandler
      .handle(() async => await authRemoteDataSource.logout());

  // 📌 Запрос кода
  @override
  Future<Either<Failure, void>> requestCode(
    String phone,
  ) async =>
      await errorHandler.handle(
        () async => await authRemoteDataSource.requestCode(phone),
      );

  // 📌 Обновление пароля
  @override
  Future<Either<Failure, bool?>> isPhoneExists(String phone) async =>
      await errorHandler.handle(
        () async => await authRemoteDataSource.isPhoneExists(phone),
      );
}
