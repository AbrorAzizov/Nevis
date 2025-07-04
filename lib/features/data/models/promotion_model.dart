import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';

class PromotionModel extends PromotionEntity {
  const PromotionModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.link,
    required super.products,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      link: json['link'],
      products: json['products'] != null
          ? (json['products'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList()
          : [],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
