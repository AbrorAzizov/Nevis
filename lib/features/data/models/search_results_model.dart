import 'package:nevis/features/data/models/product_model.dart';

import '../../domain/entities/search_results_entity.dart';

class SearchResultsModel extends SearchResultsEntity {
  const SearchResultsModel({
    required super.totalHits,
    required super.products,
    required super.facets,
    super.correction,
    super.currentPage,
    super.perPage,
    super.total,
    super.lastPage,
    super.from,
    super.to,
    super.hasMorePages,
  });

  factory SearchResultsModel.fromJson(Map<String, dynamic> json) {
    final pagination = json['pagination'] ?? {};
    return SearchResultsModel(
      totalHits: json['totalHits'] ?? 0,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
          [],
      facets: json['facets'],
      correction: json['correction'],
      currentPage: int.tryParse(pagination['current_page']?.toString() ?? '') ??
          pagination['current_page'],
      perPage: int.tryParse(pagination['per_page']?.toString() ?? '') ??
          pagination['per_page'],
      total: int.tryParse(pagination['total']?.toString() ?? '') ??
          pagination['total'],
      lastPage: int.tryParse(pagination['last_page']?.toString() ?? '') ??
          pagination['last_page'],
      from: int.tryParse(pagination['from']?.toString() ?? '') ??
          pagination['from'],
      to: int.tryParse(pagination['to']?.toString() ?? '') ?? pagination['to'],
      hasMorePages: pagination['has_more_pages'] is bool
          ? pagination['has_more_pages']
          : (pagination['has_more_pages']?.toString() == 'true'),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'totalHits': totalHits,
      'products': products.map((e) => (e as ProductModel).toJson()).toList(),
      'facets': facets,
      'correction': correction,
      'pagination': {
        'current_page': currentPage,
        'per_page': perPage,
        'total': total,
        'last_page': lastPage,
        'from': from,
        'to': to,
        'has_more_pages': hasMorePages,
      },
    };
  }
}
