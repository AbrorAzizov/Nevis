import 'dart:convert';

import 'package:nevis/features/domain/entities/action_entity.dart';



class ActionModel extends ActionEntity {
  final int? actionId;
  final String? pageTitle;
  final String? alias;
  final String? createDttm;
  final String? image;
  final String? image1400300;
  final String? image960400;

  const ActionModel({
    this.actionId,
    this.pageTitle,
    this.alias,
    this.createDttm,
    this.image,
    this.image1400300,
    this.image960400,
  }) : super(
          actionId: actionId,
          pageTitle: pageTitle,
          alias: alias,
          createDttm: createDttm,
          image: image,
          image1400300: image1400300,
          image960400: image960400,
        );

  factory ActionModel.fromRawJson(String str) =>
      ActionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActionModel.fromJson(Map<String, dynamic> json) => ActionModel(
        actionId: json["action_id"],
        pageTitle: json["pagetitle"],
        alias: json["alias"],
        createDttm: json["create_dttm"],
        image: json["image"],
        image1400300: json["image_1400_300"],
        image960400: json["image_960_400"],
      );

  Map<String, dynamic> toJson() => {
        "action_id": actionId,
        "pagetitle": pageTitle,
        "alias": alias,
        "create_dttm": createDttm,
        "image": image,
        "image_1400_300": image1400300,
        "image_960_400": image960400,
      };
}
