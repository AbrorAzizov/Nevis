import 'package:nevis/constants/extensions.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {super.productId,
      super.mnn,
      super.mnnLat,
      super.name,
      super.description,
      super.code,
      super.dose,
      super.form,
      super.brand,
      super.image,
      super.recipe,
      super.country,
      super.delivery,
      super.price,
      super.oldPrice,
      super.discount,
      super.parent,
      super.termin,
      super.temperature,
      super.releaseForm,
      super.productInsert,
      super.productSticker,
      super.productRegister,
      super.productTrademark,
      super.productDateRegister,
      super.productTimeRegister,
      super.count,
      super.valueBuy,
      super.specialOffer,
      super.images,
      super.bonuses,
      super.availableForDelivery});

  @override
  factory ProductModel.fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> json = data["product_info"] ?? data;
    return ProductModel(
      bonuses: json['bonuses'],
      images: (json["images"] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
      productId: json["id"] ?? json["product_id"],
      mnn: json["mnn"],
      mnnLat: json["mnn_lat"],
      name: json["name"],
      description: json["description"],
      code: json["code"],
      dose: json["dose"],
      form: json["form"],
      brand: json["manufacturer"],
      image: json["image_url"],
      recipe: json["recipe"],
      country: json["country"],
      delivery: json["delivery"],
      price: json["price"],
      oldPrice: json["price_old"],
      discount: int.tryParse(
        (json["product_price_from_percent"] ?? ''),
      ),
      parent: json["parent"],
      termin: json["termin"],
      temperature: json["temperature"],
      releaseForm: json["release_form"],
      productInsert: json["product_insert"],
      productSticker: json["product_sticker"],
      productRegister: json["product_register"],
      productTrademark: json["product_trademark"],
      productDateRegister: json["product_date_register"],
      productTimeRegister: json["product_time_register"],
      count: json["count"],
      valueBuy: int.tryParse(json["value_buy_price"] ?? ''),
      availableForDelivery: json['is_available_for_delivery'],
      specialOffer:
          TypeOfSpecialOfferExtension.fromTitle(json["special_offer"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_info": {
          "product_id": productId,
          "product_charachters": {
            "mnn": mnn,
            "mnn_lat": mnnLat,
            "product_title": name,
            "product_description": description,
            "code": code,
            "dose": dose,
            "form": form,
            "brand": brand,
            "image": image,
            "recipe": recipe,
            "country": country,
            "delivery": delivery,
            "product_price_from": price,
            "product_price_from_old": oldPrice,
            "product_price_from_percent": discount,
            "parent": parent,
            "termin": termin,
            "temperature": temperature,
            "release_form": releaseForm,
            "product_insert": productInsert,
            "product_sticker": productSticker,
            "product_register": productRegister,
            "product_trademark": productTrademark,
            "product_date_register": productDateRegister,
            "product_time_register": productTimeRegister,
            'count': count,
          }
        }
      };
}
