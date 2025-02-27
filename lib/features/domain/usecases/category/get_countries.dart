import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/repositories/category_repository.dart';


class GetCountriesUC extends UseCaseParam<List<String>, int> {
  final CategoryRepository categoryRepository;

  GetCountriesUC(this.categoryRepository);

  @override
  Future<Either<Failure, List<String>>> call(int params) async {
    return await categoryRepository.getCountries(params);
  }
}
