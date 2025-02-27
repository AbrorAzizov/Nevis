import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/category_entity.dart';
import 'package:nevis/features/domain/repositories/category_repository.dart';


class GetCategoriesUC extends UseCase<List<CategoryEntity>> {
  final CategoryRepository categoryRepository;

  GetCategoriesUC(this.categoryRepository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await categoryRepository.getCategories();
  }
}
