import 'dart:convert';

import 'package:nevis/features/domain/entities/news_entity.dart';


class NewsModel extends NewsEntity {
  final int? contentId;
  final String? pageTitle;
  final String? alias;
  final String? createDttm;
  final String? image;
  final String? description;
  final String? content;

  const NewsModel({
    this.contentId,
    this.pageTitle,
    this.alias,
    this.createDttm,
    this.image,
    this.description,
    this.content,
  }) : super(
          contentId: contentId,
          pageTitle: pageTitle,
          alias: alias,
          createDttm: createDttm,
          image: image,
          description: description,
          content: content,
        );

  factory NewsModel.fromRawJson(String str) =>
      NewsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        contentId: json["contentid"],
        pageTitle: json["pagetitle"],
        alias: json["alias"],
        createDttm: json["create_dttm"],
        image: json["image"],
        description: json["description"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "contentid": contentId,
        "pagetitle": pageTitle,
        "alias": alias,
        "create_dttm": createDttm,
        "image": image,
        "description": description,
        "content": content,
      };
}
