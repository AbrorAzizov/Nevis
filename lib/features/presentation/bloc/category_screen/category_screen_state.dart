part of 'category_screen_bloc.dart';

class CategoryScreenState extends Equatable {
  final bool isLoading;
  final String? errorText;
  final List<CategoryEntity>? subcategories;

  const CategoryScreenState({
    this.isLoading = true,
    this.errorText,
    this.subcategories,
  });

  CategoryScreenState copyWith({
    bool? isLoading,
    String? errorText,
    List<CategoryEntity>? subcategories,
  }) {
    return CategoryScreenState(
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText,
      subcategories: subcategories ?? this.subcategories,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorText,
        subcategories,
      ];
}
