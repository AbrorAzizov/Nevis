part of 'sales_screen_bloc.dart';

class SalesScreenState extends Equatable {
  final List<String> categories;
  final int currentCategoryIndex;

  const SalesScreenState({
    required this.categories,
    required this.currentCategoryIndex,
  });

  SalesScreenState copyWith({
    final List<String>? categories,
    final int? currentCategoryIndex,
  }) {
    return SalesScreenState(
      categories: categories ?? this.categories,
      currentCategoryIndex: currentCategoryIndex ?? this.currentCategoryIndex,
    );
  }

  @override
  List<Object> get props => [categories, currentCategoryIndex];
}
