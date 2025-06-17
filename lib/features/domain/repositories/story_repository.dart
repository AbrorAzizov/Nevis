import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';

import '../entities/paginated_stories_entity.dart';
import '../entities/story_entity.dart';

abstract class StoryRepository {
  Future<Either<Failure, PaginatedStoriesEntity>> getStories(int page);
  Future<Either<Failure, StoryEntity>> getStoryById(int id);
}
