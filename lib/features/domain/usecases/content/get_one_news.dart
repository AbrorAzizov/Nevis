import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/news_entity.dart';
import 'package:nevis/features/domain/repositories/content_repository.dart';

class GetOneNewsUC extends UseCaseParam<NewsEntity, int> {
  final ContentRepository contentRepository;

  GetOneNewsUC(this.contentRepository);

  @override
  Future<Either<Failure, NewsEntity>> call(int params) async {
    return await contentRepository.getOneNews(params);
  }
}
