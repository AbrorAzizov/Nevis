import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class PromotionEntity extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? link;
  final List<ProductEntity>? products;
  final String? createdAt;
  final String? updatedAt;

  const PromotionEntity({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.link,
    this.products,
    this.createdAt,
    this.updatedAt,
  });

  PromotionEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    String? link,
    List<ProductEntity>? products,
    String? createdAt,
    String? updatedAt,
  }) =>
      PromotionEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description:  description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        link: link ?? this.link,
        products: products ?? this.products,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imageUrl,
    link,
    products,
    createdAt,
    updatedAt,
  ];
}
