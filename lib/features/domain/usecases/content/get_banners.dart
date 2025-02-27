import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/banner_entity.dart';
import 'package:nevis/features/domain/repositories/content_repository.dart';


class GetBannersUC extends UseCase<List<BannerEntity>> {
  final ContentRepository contentRepository;

  GetBannersUC(this.contentRepository);

  @override
  Future<Either<Failure, List<BannerEntity>>> call() async {
    return await contentRepository.getBanners();
  }
}
