part of 'category_screen_bloc.dart';

abstract class CategoryScreenEvent extends Equatable {
  const CategoryScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadSubcategoriesEvent extends CategoryScreenEvent {
  final int categoryId;
  const LoadSubcategoriesEvent({required this.categoryId});
}
