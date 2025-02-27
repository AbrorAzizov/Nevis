import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String? image;
  final String? href;

  const BannerEntity({
    this.image,
    this.href,
  });

  BannerEntity copyWith({
    String? image,
    String? href,
  }) =>
      BannerEntity(
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
