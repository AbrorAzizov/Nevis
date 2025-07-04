import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class SearchProductsEntity extends Equatable {
  final int currentPage;
  final int totalPage;
  final int lastPage;
  final int totalCount;
  final List<ProductEntity> products;

  const SearchProductsEntity({
    required this.currentPage,
    required this.totalPage,
    required this.lastPage,
    required this.totalCount,
    required this.products,
  });

  // Добавляем метод copyWith
  SearchProductsEntity copyWith({
    int? currentPage,
    int? totalPage,
    int? lastPage,
    int? totalCount,
    List<ProductEntity>? products,
  }) {
    return SearchProductsEntity(
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      lastPage: lastPage ?? this.lastPage,
      totalCount: totalCount ?? this.totalCount,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
        currentPage,
        totalPage,
        lastPage,
        totalCount,
        products,
      ];
}
