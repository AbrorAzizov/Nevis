import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/login_servece_param.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/auth_repository.dart';

class LoginByServiceUC extends UseCaseParam<void, LoginServiceParam> {
  final AuthRepository authRepository;

  LoginByServiceUC(this.authRepository);

  @override
  Future<Either<Failure, void>> call(LoginServiceParam params) async {
    return await authRepository.loginByService(params);
  }
}
