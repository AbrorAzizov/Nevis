import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/platform/network_info.dart';

import '../../../core/platform/error_handler.dart';
import '../../domain/entities/paginated_stories_entity.dart';
import '../../domain/entities/story_entity.dart';
import '../../domain/repositories/story_repository.dart';
import '../datasources/story_remote_data_source_impl.dart';

class StoryRepositoryImpl extends StoryRepository {
  final StoryRemoteDataSource storyRemoteDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  StoryRepositoryImpl(
      {required this.storyRemoteDataSource,
      required this.networkInfo,
      required this.errorHandler});

  // 📌 Получение списка сторис
  @override
  Future<Either<Failure, PaginatedStoriesEntity>> getStories(int page) async =>
      await errorHandler.handle(
        () async => await storyRemoteDataSource.getStories(page),
      );

  // 📌 Получение стори по id
  @override
  Future<Either<Failure, StoryEntity>> getStoryById(int id) async =>
      await errorHandler.handle(
        () async => await storyRemoteDataSource.getStoryById(id),
      );
}
