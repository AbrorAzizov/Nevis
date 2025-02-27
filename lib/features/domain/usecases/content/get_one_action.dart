import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/action_entity.dart';
import 'package:nevis/features/domain/repositories/content_repository.dart';

class GetOneActionUC extends UseCaseParam<ActionEntity, int> {
  final ContentRepository contentRepository;

  GetOneActionUC(this.contentRepository);

  @override
  Future<Either<Failure, ActionEntity>> call(int params) async {
    return await contentRepository.getOneAction(params);
  }
}
