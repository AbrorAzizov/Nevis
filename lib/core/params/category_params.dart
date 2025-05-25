class CategoryParams {
  final String typeOfSort;
  final String sortBy;
  final int categotyId;
  final int page;

  CategoryParams(
      {required this.categotyId,
      required this.typeOfSort,
      this.sortBy = 'asc',
      this.page = 1});
}
