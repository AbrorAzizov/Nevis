import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class SearchAutocompleteEntity extends Equatable {
  final List<String> queries;
  final List<ProductEntity> products;
  final int totalHits;

  const SearchAutocompleteEntity({
    required this.queries,
    required this.products,
    required this.totalHits,
  });

  @override
  List<Object?> get props => [queries, products, totalHits];
}
