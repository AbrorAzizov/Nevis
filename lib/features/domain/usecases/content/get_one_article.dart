import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/article_entity.dart';
import 'package:nevis/features/domain/repositories/content_repository.dart';

class GetOneArticleUC extends UseCaseParam<ArticleEntity, int> {
  final ContentRepository contentRepository;

  GetOneArticleUC(this.contentRepository);

  @override
  Future<Either<Failure, ArticleEntity>> call(int params) async {
    return await contentRepository.getOneArticle(params);
  }
}
