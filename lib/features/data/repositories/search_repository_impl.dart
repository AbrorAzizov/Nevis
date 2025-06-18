import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/search_remote_data_source.dart';
import 'package:nevis/features/domain/entities/search_autocomplete_entity.dart';
import 'package:nevis/features/domain/entities/search_results_entity.dart';
import 'package:nevis/features/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  SearchRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.errorHandler,
  });

  @override
  Future<Either<Failure, SearchAutocompleteEntity>> autocompleteSearch(
      String query) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(InternetConnectionFailure());
    }

    return await errorHandler.handle(
      () async => await remoteDataSource.autocompleteSearch(query),
    );
  }

  @override
  Future<Either<Failure, SearchResultsEntity>> search({
    required String query,
    Map<String, List<String>>? categories,
    Map<String, List<String>>? brands,
    double? priceMin,
    double? priceMax,
    String? sort,
    int? page,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return const Left(InternetConnectionFailure());
    }

    return await errorHandler.handle(
      () async => await remoteDataSource.search(
        query: query,
        categories: categories,
        brands: brands,
        priceMin: priceMin,
        priceMax: priceMax,
        sort: sort,
        page: page,
      ),
    );
  }
}
