import 'package:equatable/equatable.dart';

class StoryEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String status;
  final int order;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? stepsCount;
  final List<StoryStepEntity>? steps;

  const StoryEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.order,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    this.stepsCount,
    this.steps,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        status,
        order,
        publishedAt,
        createdAt,
        updatedAt,
        stepsCount,
        steps,
      ];
}

class StoryStepEntity extends Equatable {
  final int id;
  final String text;
  final String imageUrl;
  final int order;
  final List<StoryButtonEntity> buttons;

  const StoryStepEntity({
    required this.id,
    required this.text,
    required this.imageUrl,
    required this.order,
    required this.buttons,
  });

  @override
  List<Object?> get props => [id, text, imageUrl, order, buttons];
}

class StoryButtonEntity extends Equatable {
  final int id;
  final String text;
  final String action;
  final String? url;

  const StoryButtonEntity({
    required this.id,
    required this.text,
    required this.action,
    this.url,
  });

  @override
  List<Object?> get props => [id, text, action, url];
}
