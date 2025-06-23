import 'dart:convert';

import 'package:nevis/features/domain/entities/subcategory_entity.dart';

class SubcategoryModel extends SubcategoryEntity {
  const SubcategoryModel({
    super.totalCount,
    super.totalPage,
    super.currentPage,
    super.groups,
  });

  factory SubcategoryModel.fromRawJson(String str) =>
      SubcategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    final categories = json["categories"];

    List<GroupModel>? parsedGroups;

    if (categories != null &&
        categories is List &&
        categories.isNotEmpty &&
        categories[0]["groups"] != null &&
        categories[0]["groups"] is List) {
      parsedGroups = List<GroupModel>.from(
        categories[0]["groups"].map((x) => GroupModel.fromJson(x)),
      );
    }

    return SubcategoryModel(
      totalCount: json["totalCount"],
      totalPage: json["totalPage"],
      currentPage: json["currentPage"],
      groups: parsedGroups,
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "totalPage": totalPage,
        "currentPage": currentPage,
        "groups": groups?.map((x) => (x as SubcategoryModel).toJson()).toList(),
      };
}

class GroupModel extends GroupEntity {
  const GroupModel({super.id, super.name, super.iblockSectionId});

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["id"],
        name: json["name"],
        iblockSectionId: json["iblock_section_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iblock_section_id": iblockSectionId,
      };
}
