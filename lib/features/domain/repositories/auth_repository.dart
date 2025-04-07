import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool?>> isPhoneExists(String phone);
  Future<Either<Failure, void>> requestCode(String phone);
  Future<Either<Failure, void>> login(String phone, String code);
  Future<Either<Failure, void>> logout();
}
