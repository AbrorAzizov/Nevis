import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';


abstract class AuthRepository {
  Future<Either<Failure, bool?>> isPhoneExists(String phone);
  Future<Either<Failure, int>> requestCode(String phone);
  Future<Either<Failure, void>> registration(String phone, String code);
  Future<Either<Failure, void>> updatePassword(
      String phone, String password, String code);
  Future<Either<Failure, void>> login(String phone, String password);
  Future<Either<Failure, void>> logout();
}
