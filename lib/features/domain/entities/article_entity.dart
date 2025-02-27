import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final int? contentId;
  final String? pageTitle;
  final String? alias;
  final String? content;
  final String? createDttm;
  final String? image;
  final String? shortDescription;

  const ArticleEntity({
    this.contentId,
    this.pageTitle,
    this.alias,
    this.content,
    this.createDttm,
    this.image,
    this.shortDescription,
  });

  ArticleEntity copyWith({
    int? contentId,
    String? pageTitle,
    String? alias,
    String? content,
    String? createDttm,
    String? image,
    String? shortDescription,
  }) =>
      ArticleEntity(
        contentId: contentId ?? this.contentId,
        pageTitle: pageTitle ?? this.pageTitle,
        alias: alias ?? this.alias,
        content: content ?? this.content,
        createDttm: createDttm ?? this.createDttm,
        image: image ?? this.image,
        shortDescription: shortDescription ?? this.shortDescription,
      );

  @override
  List<Object?> get props => [
        contentId,
        pageTitle,
        alias,
        content,
        createDttm,
        image,
        shortDescription,
      ];
}
