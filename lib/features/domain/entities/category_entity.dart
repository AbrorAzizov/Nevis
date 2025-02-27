import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int? categoryId;
  final int? parent;
  final String? pageTitle;
  final String? alias;
  final String? image;

  const CategoryEntity({
    this.categoryId,
    this.parent,
    this.pageTitle,
    this.alias,
    this.image,
  });

  CategoryEntity copyWith({
    int? categoryId,
    int? parent,
    String? pageTitle,
    String? alias,
    String? image,
  }) =>
      CategoryEntity(
        categoryId: categoryId ?? this.categoryId,
        parent: parent ?? this.parent,
        pageTitle: pageTitle ?? this.pageTitle,
        alias: alias ?? this.alias,
        image: image ?? this.image,
      );

  @override
  List<Object?> get props => [
        categoryId,
        parent,
        pageTitle,
        alias,
        image,
      ];
}
