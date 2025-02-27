import 'dart:convert';

import 'package:nevis/features/domain/entities/article_entity.dart';


class ArticleModel extends ArticleEntity {
  final int? contentId;
  final String? pageTitle;
  final String? alias;
  final String? content;
  final String? createDttm;
  final String? image;
  final String? shortDescription;

  const ArticleModel({
    this.contentId,
    this.pageTitle,
    this.alias,
    this.content,
    this.createDttm,
    this.image,
    this.shortDescription,
  }) : super(
          contentId: contentId,
          pageTitle: pageTitle,
          alias: alias,
          content: content,
          createDttm: createDttm,
          image: image,
          shortDescription: shortDescription,
        );

  factory ArticleModel.fromRawJson(String str) =>
      ArticleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        contentId: json["contentid"],
        pageTitle: json["pagetitle"],
        alias: json["alias"],
        content: json["content"],
        createDttm: json["create_dttm"],
        image: json["image"],
        shortDescription: json["short_description"],
      );

  Map<String, dynamic> toJson() => {
        "contentid": contentId,
        "pagetitle": pageTitle,
        "alias": alias,
        "content": content,
        "create_dttm": createDttm,
        "image": image,
        "short_description": shortDescription,
      };
}
