import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/features/data/models/profile_model.dart';
import 'package:nevis/features/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getMe();
  Future<Either<Failure, void>> updateMe(ProfileModel profile);
  Future<Either<Failure, void>> deleteMe();
}
