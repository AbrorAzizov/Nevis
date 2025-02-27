import 'dart:convert';

import 'package:nevis/features/domain/entities/banner_entity.dart';


class BannerModel extends BannerEntity {
  final String? image;
  final String? href;

  const BannerModel({
    this.image,
    this.href,
  }) : super(
          image: image,
          href: href,
        );

  factory BannerModel.fromRawJson(String str) =>
      BannerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        image: json["image"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "href": href,
      };
}
