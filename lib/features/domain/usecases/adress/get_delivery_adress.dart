import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/adress_entity.dart';
import 'package:nevis/features/domain/entities/cart_entity.dart';
import 'package:nevis/features/domain/repositories/profile_repository.dart';

class GetDeliveryAdressUC extends UseCase<AddressEntity> {
   final ProfileRepository profileRepository;

  GetDeliveryAdressUC(this.profileRepository);

  @override
  Future<Either<Failure, AddressEntity>> call() async {
    return await profileRepository.getDeliveryAdress();
  }
}
