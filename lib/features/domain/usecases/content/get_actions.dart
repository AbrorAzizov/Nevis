import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/action_entity.dart';
import 'package:nevis/features/domain/repositories/content_repository.dart';

class GetActionsUC extends UseCase<List<ActionEntity>> {
  final ContentRepository contentRepository;

  GetActionsUC(this.contentRepository);

  @override
  Future<Either<Failure, List<ActionEntity>>> call() async {
    return await contentRepository.getActions();
  }
}
