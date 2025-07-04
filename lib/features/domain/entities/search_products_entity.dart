import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class SearchProductsEntity extends Equatable {
  final int currentPage;
  final int totalPage;
  final int totalCount;
  final int lastPage;
  final List<ProductEntity> products;

  const SearchProductsEntity({
    required this.currentPage,
    required this.totalPage,
    required this.totalCount,
    required this.lastPage,
    required this.products,
  });

  // Добавляем метод copyWith
  SearchProductsEntity copyWith({
    int? currentPage,
    int? totalPage,
    int? totalCount,
    int? lastPage,
    List<ProductEntity>? products,
  }) {
    return SearchProductsEntity(
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      totalCount: totalCount ?? this.totalCount,
      lastPage: lastPage ?? this.lastPage,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
        currentPage,
        totalPage,
        totalCount,
        products,
        lastPage,
      ];
}
