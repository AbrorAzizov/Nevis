import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';

import '../entities/search_autocomplete_entity.dart';
import '../entities/search_results_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchAutocompleteEntity>> autocompleteSearch(
      String query);
  Future<Either<Failure, SearchResultsEntity>> search({
    required String query,
    Map<String, List<String>>? categories,
    Map<String, List<String>>? brands,
    double? priceMin,
    double? priceMax,
    String? sort,
    int? page,
  });
}
