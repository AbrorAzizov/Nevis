import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/authentification_param.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/auth_repository.dart';


class IsPhoneExistsUC extends UseCaseParam<void, AuthenticationParams> {
  final AuthRepository authRepository;

  IsPhoneExistsUC(this.authRepository);

  @override
  Future<Either<Failure, bool?>> call(AuthenticationParams params) async {
    return await authRepository.isPhoneExists(params.phone);
  }
}
