import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/profile_entity.dart';
import 'package:nevis/features/domain/repositories/profile_repository.dart';

class GetMeUC extends UseCase<ProfileEntity> {
  final ProfileRepository profileRepository;

  GetMeUC(this.profileRepository);

  @override
  Future<Either<Failure, ProfileEntity>> call() async {
    return await profileRepository.getMe();
  }
}
