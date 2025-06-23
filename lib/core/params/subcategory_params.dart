class SubcategoryParams {
  final int? categoryId;
  final String sort;
  final String order;
  final int page;

  SubcategoryParams({
    this.categoryId,
    this.sort = 'name',
    this.order = 'asc',
    this.page = 1,
  });

  SubcategoryParams copyWith({
    int? categoryId,
    String? sort,
    String? order,
    int? page,
  }) {
    return SubcategoryParams(
      categoryId: categoryId ?? this.categoryId,
      sort: sort ?? this.sort,
      order: order ?? this.order,
      page: page ?? this.page,
    );
  }
}
