import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/search_autocomplete_entity.dart';
import 'package:nevis/features/domain/repositories/search_repository.dart';

class AutocompleteSearchUC
    extends UseCaseParam<SearchAutocompleteEntity, String> {
  final SearchRepository repository;

  AutocompleteSearchUC(this.repository);

  @override
  Future<Either<Failure, SearchAutocompleteEntity>> call(String params) async {
    return await repository.autocompleteSearch(params);
  }
}
