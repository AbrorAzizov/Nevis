class SearchParams {
  final String query;
  final Map<String, List<String>>? categories;
  final Map<String, List<String>>? brands;
  final double? priceMin;
  final double? priceMax;
  final String? sort;
  final int? page;

  const SearchParams(
      {required this.query,
      this.categories,
      this.brands,
      this.priceMin,
      this.priceMax,
      this.sort,
      this.page});

  SearchParams copyWith({
    String? query,
    Map<String, List<String>>? categories,
    Map<String, List<String>>? brands,
    double? priceMin,
    double? priceMax,
    String? sort,
    int? page,
  }) {
    return SearchParams(
      query: query ?? this.query,
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      sort: sort ?? this.sort,
      page: page ?? this.page,
    );
  }
}
