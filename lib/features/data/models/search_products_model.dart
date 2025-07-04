import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/search_products_entity.dart';

class SearchProductsModel extends SearchProductsEntity {
  const SearchProductsModel({
    required super.currentPage,
    required super.lastPage,
    required super.totalCount,
    required super.products,
    required super.totalPage,
  });

  factory SearchProductsModel.fromJson(Map<String, dynamic> json) {
    return SearchProductsModel(
      currentPage: json['currentPage'],
      lastPage: json['totalPage'],
      totalPage: json['totalPage'],
      totalCount: json['totalCount'],
      products: json['products'] != null
          ? (json['products'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList()
          : [],
    );
  }
}
