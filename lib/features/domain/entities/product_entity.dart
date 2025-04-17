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

  const ProductEntity(
      {this.productId,
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
      this.specialOffer});

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
        bonuses
      ];
}
