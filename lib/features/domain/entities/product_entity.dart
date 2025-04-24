import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';

class ProductEntity extends Equatable {
  final int? productId;
  final int? bonuses;
  final String? mnn;
  final String? mnnLat;
  final String? name;
  final String? description;
  final String? code;
  final String? dose;
  final String? form;
  final String? brand;
  final String? image;
  final String? recipe;
  final String? country;
  final String? delivery;
  final int? price;
  final int? oldPrice;
  final int? discount;
  final int? parent;
  final String? termin;
  final String? temperature;
  final String? releaseForm;
  final String? productInsert;
  final String? productSticker;
  final String? productRegister;
  final String? productTrademark;
  final String? productDateRegister;
  final String? productTimeRegister;
  final int? count;
  final int? valueBuy;
  final TypeOfSpecialOffer? specialOffer;
  final bool? availableForDelivery;
  final List<String>? images;
  final bool? isFav;

  const ProductEntity({
    this.productId,
    this.availableForDelivery,
    this.bonuses,
    this.images,
    this.valueBuy,
    this.mnn,
    this.mnnLat,
    this.name,
    this.description,
    this.code,
    this.dose,
    this.form,
    this.brand,
    this.image,
    this.recipe,
    this.country,
    this.delivery,
    this.price,
    this.oldPrice,
    this.discount,
    this.parent,
    this.termin,
    this.temperature,
    this.releaseForm,
    this.productInsert,
    this.productSticker,
    this.productRegister,
    this.productTrademark,
    this.productDateRegister,
    this.productTimeRegister,
    this.count,
    this.specialOffer,
    this.isFav,
  });

  ProductEntity copyWith({
    int? productId,
    int? bonuses,
    String? mnn,
    String? mnnLat,
    String? name,
    String? description,
    String? code,
    String? dose,
    String? form,
    String? brand,
    String? image,
    String? recipe,
    String? country,
    String? delivery,
    int? price,
    int? oldPrice,
    int? discount,
    int? parent,
    String? termin,
    String? temperature,
    String? releaseForm,
    String? productInsert,
    String? productSticker,
    String? productRegister,
    String? productTrademark,
    String? productDateRegister,
    String? productTimeRegister,
    int? count,
    int? valueBuy,
    TypeOfSpecialOffer? specialOffer,
    bool? availableForDelivery,
    List<String>? images,
    bool? isFav,
  }) {
    return ProductEntity(
      productId: productId ?? this.productId,
      bonuses: bonuses ?? this.bonuses,
      mnn: mnn ?? this.mnn,
      mnnLat: mnnLat ?? this.mnnLat,
      name: name ?? this.name,
      description: description ?? this.description,
      code: code ?? this.code,
      dose: dose ?? this.dose,
      form: form ?? this.form,
      brand: brand ?? this.brand,
      image: image ?? this.image,
      recipe: recipe ?? this.recipe,
      country: country ?? this.country,
      delivery: delivery ?? this.delivery,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      discount: discount ?? this.discount,
      parent: parent ?? this.parent,
      termin: termin ?? this.termin,
      temperature: temperature ?? this.temperature,
      releaseForm: releaseForm ?? this.releaseForm,
      productInsert: productInsert ?? this.productInsert,
      productSticker: productSticker ?? this.productSticker,
      productRegister: productRegister ?? this.productRegister,
      productTrademark: productTrademark ?? this.productTrademark,
      productDateRegister: productDateRegister ?? this.productDateRegister,
      productTimeRegister: productTimeRegister ?? this.productTimeRegister,
      count: count ?? this.count,
      valueBuy: valueBuy ?? this.valueBuy,
      specialOffer: specialOffer ?? this.specialOffer,
      availableForDelivery: availableForDelivery ?? this.availableForDelivery,
      images: images ?? this.images,
      isFav: isFav ?? this.isFav,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        mnn,
        mnnLat,
        name,
        description,
        code,
        dose,
        form,
        brand,
        image,
        recipe,
        country,
        delivery,
        price,
        oldPrice,
        discount,
        parent,
        termin,
        temperature,
        releaseForm,
        productInsert,
        productSticker,
        productRegister,
        productTrademark,
        productDateRegister,
        productTimeRegister,
        count,
        specialOffer,
        availableForDelivery,
        images,
        bonuses,
        isFav,
      ];
}
