import 'package:nevis/features/data/models/product_model.dart';

import '../../domain/entities/search_autocomplete_entity.dart';

class SearchAutocompleteModel extends SearchAutocompleteEntity {
  const SearchAutocompleteModel({
    required super.queries,
    required super.products,
    required super.totalHits,
  });

  factory SearchAutocompleteModel.fromJson(Map<String, dynamic> json) {
    return SearchAutocompleteModel(
      queries: List<String>.from(json['queries'] ?? []),
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
          [],
      totalHits: json['totalHits'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'queries': queries,
      'products': products.map((e) => (e as ProductModel).toJson()).toList(),
      'totalHits': totalHits,
    };
  }
}
