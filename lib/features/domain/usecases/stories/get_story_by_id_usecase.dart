import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/story_entity.dart';
import 'package:nevis/features/domain/repositories/story_repository.dart';

class GetStoryByIdUC extends UseCaseParam<StoryEntity, int> {
  final StoryRepository storyRepository;
  GetStoryByIdUC(this.storyRepository);

  @override
  Future<Either<Failure, StoryEntity>> call(int params) async {
    return await storyRepository.getStoryById(params);
  }
}
