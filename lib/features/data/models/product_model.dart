import 'package:nevis/constants/extensions.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    super.productId,
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
    super.availableForDelivery,
    super.maxCount,
    super.offerId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    final json = data["product_info"] ?? data;

    final dynamic idField = json['id'];
    final dynamic productIdField =
        json['productId'] ?? json['product_id'] ?? json['PRODUCT_ID'];

    final int? parsedProductId =
        _parseToInt(productIdField) ?? (idField is int ? idField : null);

    return ProductModel(
      offerId: idField is String ? idField : null,
      productId: parsedProductId ?? 0,
      mnn: json["mnn"],
      mnnLat: json["mnn_lat"],
      name: json["name"],
      description: json["description"],
      code: json["code"],
      dose: json["dose"],
      form: json["form"],
      brand: json["manufacturer"],
      image: json["image_url"] ?? json["picture"] ?? json['image'],
      recipe: json["recipe"],
      country: json["country"],
      delivery: json["delivery"],
      price: _parseToInt(json["price"]) ?? _parseToInt(json["PRICE"]) ?? 0,
      oldPrice: _parseToInt(json["price_old"]),
      discount: _parseToInt(json["product_price_from_percent"]),
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
      count: _parseToInt(json["count"]) ??
          _parseToInt(json["quantity"]) ??
          _parseToInt(json["QUANTITY"]) ??
          _parseToInt(json["amount"]),
      valueBuy: _parseToInt(json["value_buy_price"]),
      availableForDelivery: json['is_available_for_delivery'],
      specialOffer:
          TypeOfSpecialOfferExtension.fromTitle(json["special_offer"]),
      bonuses: _parseToInt(json['bonuses'] ?? json['bonuses_earned']),
      images: (json["images"] as List?)?.map((e) => e.toString()).toList(),
      maxCount: _parseToInt(json['maxAmount']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_info": {
        "id": productId,
        "mnn": mnn,
        "mnn_lat": mnnLat,
        "name": name,
        "description": description,
        "code": code,
        "dose": dose,
        "form": form,
        "manufacturer": brand,
        "image_url": image,
        "picture": image,
        "recipe": recipe,
        "country": country,
        "delivery": delivery,
        "price": price,
        "price_old": oldPrice,
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
        "count": count,
        "value_buy_price": valueBuy,
        "is_available_for_delivery": availableForDelivery,
        "special_offer": "1+1",
        "bonuses": bonuses,
        "images": images,
      },
    };
  }

  static int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) {
      if (value.contains(',') || value.contains('.')) {
        final parsed = double.tryParse(value.replaceAll(',', '.'));
        return parsed?.round();
      } else {
        return int.tryParse(value);
      }
    }
    return null;
  }
}
