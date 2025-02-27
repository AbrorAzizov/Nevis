import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/article_entity.dart';
import 'package:nevis/features/domain/repositories/content_repository.dart';

class GetArticlesUC extends UseCase<List<ArticleEntity>> {
  final ContentRepository contentRepository;

  GetArticlesUC(this.contentRepository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call() async {
    return await contentRepository.getArticles();
  }
}
