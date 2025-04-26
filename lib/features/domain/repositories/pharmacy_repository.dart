import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';

abstract class PharmacyRepository {
  Future<Either<Failure, List<PharmacyEntity>>> getFavoritePharmacies();
}
