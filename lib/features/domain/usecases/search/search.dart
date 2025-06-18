import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/search_param.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/search_results_entity.dart';
import 'package:nevis/features/domain/repositories/search_repository.dart';

class SearchUC extends UseCaseParam<SearchResultsEntity, SearchParams> {
  final SearchRepository repository;

  SearchUC(this.repository);

  @override
  Future<Either<Failure, SearchResultsEntity>> call(SearchParams params) async {
    return await repository.search(
      query: params.query,
      categories: params.categories,
      brands: params.brands,
      priceMin: params.priceMin,
      priceMax: params.priceMax,
      sort: params.sort,
      page: params.page,
    );
  }
}
