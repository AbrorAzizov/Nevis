import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/data/models/profile_model.dart';
import 'package:nevis/features/domain/repositories/profile_repository.dart';

class UpdateMeUC extends UseCaseParam<void, ProfileModel> {
  final ProfileRepository profileRepository;

  UpdateMeUC(this.profileRepository);

  @override
  Future<Either<Failure, void>> call(ProfileModel params) async {
    return await profileRepository.updateMe(params);
  }
}
