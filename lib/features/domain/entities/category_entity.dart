import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? categoryId;
  final String? pageTitle;
  final String? image;
  const CategoryEntity({
    this.categoryId,
    this.pageTitle,
    this.image,
  });

  CategoryEntity copyWith({
    String? categoryId,
    String? pageTitle,
    String? image,
  }) =>
      CategoryEntity(
        categoryId: categoryId ?? this.categoryId,
        pageTitle: pageTitle ?? this.pageTitle,
        image: image ?? this.image,
      );

  @override
  List<Object?> get props => [
        categoryId,
        pageTitle,
        image,
      ];
}
