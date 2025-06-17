import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/paginated_stories_entity.dart';
import 'package:nevis/features/domain/repositories/story_repository.dart';

class GetStoriesUC extends UseCaseParam<PaginatedStoriesEntity, int> {
  final StoryRepository storyRepository;
  GetStoriesUC(this.storyRepository);

  @override
  Future<Either<Failure, PaginatedStoriesEntity>> call(int params) async {
    return await storyRepository.getStories(params);
  }
}
