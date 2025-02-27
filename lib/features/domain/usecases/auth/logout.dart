import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/auth_repository.dart';


class LogoutUC extends UseCase<void> {
  final AuthRepository authRepository;

  LogoutUC(this.authRepository);

  @override
  Future<Either<Failure, void>> call() async {
    return await authRepository.logout();
  }
}
