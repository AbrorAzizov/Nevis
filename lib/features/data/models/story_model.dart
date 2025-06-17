import '../../domain/entities/story_entity.dart';

class StoryModel extends StoryEntity {
  const StoryModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.status,
    required super.order,
    required super.publishedAt,
    required super.createdAt,
    required super.updatedAt,
    super.stepsCount,
    super.steps,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      status: json['status'],
      order: json['order'],
      publishedAt: DateTime.parse(json['published_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      stepsCount: json['steps_count'],
      steps: json['steps'] != null
          ? List<StoryStepModel>.from(
              json['steps'].map((x) => StoryStepModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'status': status,
      'order': order,
      'published_at': publishedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'steps_count': stepsCount,
      'steps': steps?.map((x) => (x as StoryStepModel).toJson()).toList(),
    };
  }
}

class StoryStepModel extends StoryStepEntity {
  const StoryStepModel({
    required super.id,
    required super.text,
    required super.imageUrl,
    required super.order,
    required super.buttons,
  });

  factory StoryStepModel.fromJson(Map<String, dynamic> json) {
    return StoryStepModel(
      id: json['id'],
      text: json['text'],
      imageUrl: json['image_url'],
      order: json['order'],
      buttons: List<StoryButtonModel>.from(
          json['buttons'].map((x) => StoryButtonModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'image_url': imageUrl,
      'order': order,
      'buttons': buttons.map((x) => (x as StoryButtonModel).toJson()).toList(),
    };
  }
}

class StoryButtonModel extends StoryButtonEntity {
  const StoryButtonModel({
    required super.id,
    required super.text,
    required super.action,
    super.url,
  });

  factory StoryButtonModel.fromJson(Map<String, dynamic> json) {
    return StoryButtonModel(
      id: json['id'],
      text: json['text'],
      action: json['action'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'action': action,
      'url': url,
    };
  }
}
