import 'dart:convert';

import 'package:nevis/features/domain/entities/category_entity.dart';


class CategoryModel extends CategoryEntity {
  final int? categoryId;
  final int? parent;
  final String? pageTitle;
  final String? alias;
  final String? image;

  const CategoryModel({
    this.categoryId,
    this.parent,
    this.pageTitle,
    this.alias,
    this.image,
  }) : super(
          categoryId: categoryId,
          parent: parent,
          pageTitle: pageTitle,
          alias: alias,
          image: image,
        );

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json["category_id"],
        parent: json["parent"],
        pageTitle: json["pagetitle"],
        alias: json["alias"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "parent": parent,
        "pagetitle": pageTitle,
        "alias": alias,
        "image": image,
      };
}
