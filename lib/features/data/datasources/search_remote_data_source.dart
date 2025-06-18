import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';

import '../models/search_autocomplete_model.dart';
import '../models/search_results_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchAutocompleteModel> autocompleteSearch(String query);
  Future<SearchResultsModel> search({
    required String query,
    Map<String, List<String>>? categories,
    Map<String, List<String>>? brands,
    double? priceMin,
    double? priceMax,
    String? sort,
    int? page,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiClient apiClient;

  SearchRemoteDataSourceImpl({
    required this.apiClient,
  });

  @override
  Future<SearchAutocompleteModel> autocompleteSearch(String query) async {
    try {
      final data = await apiClient.get(
          endpoint: 'search/autocomplete',
          exceptions: {500: ServerException()},
          callPathNameForLog: '${runtimeType.toString()}.autocompleteSearch',
          queryParameters: {'query': query});

      return SearchAutocompleteModel.fromJson(data['data']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SearchResultsModel> search({
    required String query,
    Map<String, List<String>>? categories,
    Map<String, List<String>>? brands,
    double? priceMin,
    double? priceMax,
    String? sort,
    int? page,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {'query': query};

      if (categories != null) {
        queryParams['filters[categories]'] =
            categories.values.expand((e) => e).toList();
      }

      if (brands != null) {
        queryParams['filters[brands]'] =
            brands.values.expand((e) => e).toList();
      }

      if (priceMin != null) {
        queryParams['filters[price_min]'] = priceMin.toString();
      }

      if (priceMax != null) {
        queryParams['filters[price_max]'] = priceMax.toString();
      }

      if (sort != null) {
        queryParams['sort'] = sort;
      }

      if (page != null) {
        queryParams['page'] = page.toString();
      }

      final data = await apiClient.get(
          endpoint: 'search',
          exceptions: {500: ServerException()},
          callPathNameForLog: '${runtimeType.toString()}.autocompleteSearch',
          queryParameters: queryParams);

      return SearchResultsModel.fromJson(data['data']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
