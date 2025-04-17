class CategoryParams {
  final String typeOfSort;
  final String sortBy;
  final int categotyId;

  CategoryParams(
      {required this.categotyId,
      required this.typeOfSort,
      this.sortBy = 'asc'});
}
