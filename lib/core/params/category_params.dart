class CategoryParams {
  final String typeOfSort;
  final String sortBy;
  final int? categoryId;
  final int page;

  CategoryParams({
    this.categoryId,
    this.typeOfSort = '',
    this.sortBy = 'asc',
    this.page = 1,
  });

  CategoryParams copyWith({
    String? typeOfSort,
    String? sortBy,
    int? categoryId,
    int? page,
  }) {
    return CategoryParams(
      typeOfSort: typeOfSort ?? this.typeOfSort,
      sortBy: sortBy ?? this.sortBy,
      categoryId: categoryId ?? this.categoryId,
      page: page ?? this.page,
    );
  }
}
