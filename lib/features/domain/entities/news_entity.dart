import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final int? contentId;
  final String? pageTitle;
  final String? alias;
  final String? createDttm;
  final String? image;
  final String? description;
  final String? content;

  const NewsEntity({
    this.contentId,
    this.pageTitle,
    this.alias,
    this.createDttm,
    this.image,
    this.description,
    this.content,
  });

  NewsEntity copyWith({
    int? contentId,
    String? pageTitle,
    String? alias,
    String? createDttm,
    String? image,
    String? description,
    String? content,
  }) =>
      NewsEntity(
        contentId: contentId ?? this.contentId,
        pageTitle: pageTitle ?? this.pageTitle,
        alias: alias ?? this.alias,
        createDttm: createDttm ?? this.createDttm,
        image: image ?? this.image,
        description: description ?? this.description,
        content: content ?? this.content,
      );

  @override
  List<Object?> get props => [
        contentId,
        pageTitle,
        alias,
        createDttm,
        image,
        description,
        content,
      ];
}
