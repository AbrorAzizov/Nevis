import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String? image;
  final String? href;

  const CartEntity({
    this.image,
    this.href,
  });

  CartEntity copyWith({
    String? image,
    String? href,
  }) =>
      CartEntity(
        image: image ?? this.image,
        href: href ?? this.href,
      );

  @override
  List<Object?> get props => [
        image,
        href,
        image,
      ];
}
