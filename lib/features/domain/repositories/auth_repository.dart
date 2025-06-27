import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/login_servece_param.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool?>> isPhoneExists(String phone);
  Future<Either<Failure, void>> requestCode(String phone);
  Future<Either<Failure, void>> refreshToken();
  Future<Either<Failure, void>> login(
      String phone, String code, String fcmToken);
  Future<Either<Failure, void>> loginByService(
      LoginServiceParam loginServiceParam);
  Future<Either<Failure, void>> logout();
}
