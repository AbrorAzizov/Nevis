import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/features/domain/entities/action_entity.dart';
import 'package:nevis/features/domain/entities/article_entity.dart';
import 'package:nevis/features/domain/entities/banner_entity.dart';
import 'package:nevis/features/domain/entities/news_entity.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';


abstract class ContentRepository {
  Future<Either<Failure, List<NewsEntity>>> getNews();
  Future<Either<Failure, NewsEntity>> getOneNews(int id);
  Future<Either<Failure, List<ActionEntity>>> getActions();
  Future<Either<Failure, ActionEntity>> getOneAction(int id);
  Future<Either<Failure, List<ArticleEntity>>> getArticles();
  Future<Either<Failure, ArticleEntity>> getOneArticle(int id);
  Future<Either<Failure, List<BannerEntity>>> getBanners();
  Future<Either<Failure, List<PharmacyEntity>>> getPharmacies(String address);
}
