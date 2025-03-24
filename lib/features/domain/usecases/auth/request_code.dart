import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/authentification_param.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/auth_repository.dart';

class RequestCodeUC extends UseCaseParam<void, AuthenticationParams> {
  final AuthRepository authRepository;

  RequestCodeUC(this.authRepository);

  @override
  Future<Either<Failure, void>> call(AuthenticationParams params) async {
    return await authRepository.requestCode(params.phone);
  }
}
