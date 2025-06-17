import 'package:equatable/equatable.dart';

import 'story_entity.dart';

class PaginatedStoriesEntity extends Equatable {
  final List<StoryEntity> data;
  final PaginationMetaEntity meta;

  const PaginatedStoriesEntity({
    required this.data,
    required this.meta,
  });

  @override
  List<Object?> get props => [data, meta];
}

class PaginationMetaEntity extends Equatable {
  final int currentPage;
  final int perPage;
  final int total;
  final int lastPage;

  const PaginationMetaEntity({
    required this.currentPage,
    required this.perPage,
    required this.total,
    required this.lastPage,
  });

  @override
  List<Object?> get props => [currentPage, perPage, total, lastPage];
}
