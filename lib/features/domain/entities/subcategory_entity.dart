import 'package:equatable/equatable.dart';

class SubcategoryEntity extends Equatable {
  final int? totalCount;
  final int? totalPage;
  final int? currentPage;
  final List<GroupEntity>? groups;
  const SubcategoryEntity({
    this.totalCount,
    this.totalPage,
    this.currentPage,
    this.groups,
  });

  SubcategoryEntity copyWith({
    int? totalCount,
    int? totalPage,
    int? currentPage,
    List<GroupEntity>? groups,
  }) =>
      SubcategoryEntity(
        totalCount: totalCount ?? this.totalCount,
        totalPage: totalPage ?? this.totalPage,
        currentPage: currentPage ?? this.currentPage,
        groups: groups ?? this.groups,
      );

  @override
  List<Object?> get props => [
        totalCount,
        totalPage,
        currentPage,
        groups,
      ];
}

class GroupEntity extends Equatable {
  final String? id;
  final String? name;
  final String? iblockSectionId;

  const GroupEntity({this.id, this.name, this.iblockSectionId});

  @override
  List<Object?> get props => [id, name, iblockSectionId];
}
