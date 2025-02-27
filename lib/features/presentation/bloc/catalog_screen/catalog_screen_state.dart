part of 'catalog_screen_bloc.dart';

class CatalogScreenState extends Equatable {
  final bool isLoading;
  final String? errorText;
  final List<CategoryEntity>? categories;

  const CatalogScreenState({
    this.isLoading = true,
    this.errorText,
    this.categories,
  });

  CatalogScreenState copyWith({
    bool? isLoading,
    String? errorText,
    List<CategoryEntity>? categories,
  }) {
    return CatalogScreenState(
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorText,
        categories,
      ];
}
