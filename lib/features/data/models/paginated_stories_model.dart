import '../../domain/entities/paginated_stories_entity.dart';
import 'story_model.dart';

class PaginatedStoriesModel extends PaginatedStoriesEntity {
  const PaginatedStoriesModel({
    required super.data,
    required super.meta,
  });

  factory PaginatedStoriesModel.fromJson(Map<String, dynamic> json) {
    return PaginatedStoriesModel(
      data: List<StoryModel>.from(
          json['data'].map((x) => StoryModel.fromJson(x))),
      meta: PaginationMetaModel.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((x) => (x as StoryModel).toJson()).toList(),
      'meta': (meta as PaginationMetaModel).toJson(),
    };
  }
}

class PaginationMetaModel extends PaginationMetaEntity {
  const PaginationMetaModel({
    required super.currentPage,
    required super.perPage,
    required super.total,
    required super.lastPage,
  });

  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return PaginationMetaModel(
      currentPage: json['current_page'],
      perPage: json['per_page'],
      total: json['total'],
      lastPage: json['last_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'per_page': perPage,
      'total': total,
      'last_page': lastPage,
    };
  }
}
