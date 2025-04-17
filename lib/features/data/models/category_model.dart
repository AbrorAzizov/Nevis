import 'dart:convert';

import 'package:nevis/features/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  @override
  final String? categoryId;

  @override
  final String? pageTitle;

  @override
  final String? image;

  const CategoryModel({
    this.categoryId,
    this.pageTitle,
    this.image,
  }) : super(
          categoryId: categoryId,
          pageTitle: pageTitle,
          image: image,
        );

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json["id"],
        pageTitle: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": categoryId,
        "name": pageTitle,
        "image": image,
      };
}
