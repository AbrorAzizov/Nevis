import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/profile_repository.dart';

class DeleteMeUC extends UseCase<void> {
  final ProfileRepository profileRepository;

  DeleteMeUC(this.profileRepository);

  @override
  Future<Either<Failure, void>> call() async {
    return await profileRepository.deleteMe();
  }
}
