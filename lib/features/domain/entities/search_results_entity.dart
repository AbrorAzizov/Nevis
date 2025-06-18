import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class SearchResultsEntity extends Equatable {
  final int totalHits;
  final List<ProductEntity> products;
  final List<dynamic> facets;
  final String? correction;
  final int? currentPage;
  final int? perPage;
  final int? total;
  final int? lastPage;
  final int? from;
  final int? to;
  final bool? hasMorePages;

  const SearchResultsEntity({
    required this.totalHits,
    required this.products,
    required this.facets,
    this.correction,
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
    this.from,
    this.to,
    this.hasMorePages,
  });

  @override
  List<Object?> get props => [
        totalHits,
        products,
        facets,
        correction,
        currentPage,
        perPage,
        total,
        lastPage,
        from,
        to,
        hasMorePages
      ];
}

class SearchResultProductEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final String brand;
  final String category;
  final String image;
  final String url;
  final bool available;

  const SearchResultProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.brand,
    required this.category,
    required this.image,
    required this.url,
    required this.available,
  });

  @override
  List<Object?> get props =>
      [id, name, price, brand, category, image, url, available];
}
