import 'package:nevis/constants/enums.dart';
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
    super.cashbackPercent,
    super.availableForDelivery,
    super.offerId,
    this.maxCount,
    super.utsenkaPrice,
  });

  @override
  final int? maxCount;

  @override
  factory ProductModel.fromJson(Map<String, dynamic> data) {
    final json = data["product_info"] ?? data;

    final dynamic idField = json['id'];
    final dynamic productIdField =
        json['productId'] ?? json['product_id'] ?? json['PRODUCT_ID'];

    final int? parsedProductId = _parseToInt(productIdField) ??
        (idField is int ? idField : _parseToInt(idField));

    List<dynamic>? images = json["images"];

    String? image = json["image_url"] ??
        json["picture"] ??
        json["image"] ??
        (images != null && images.isNotEmpty ? images.first : null);

    return ProductModel(
      offerId: idField is String ? idField : null,
      productId: parsedProductId ?? 0,
      bonuses: _parseToInt(json['bonuses'] ??
          json['bonuses_earned'] ??
          json['CASHBACK_BONUSES'] ??
          json['discounts']?['CASHBACK_BONUSES']),
      cashbackPercent: json['CASHBACK_PERCENT'] != null
          ? (json['CASHBACK_PERCENT'] as num).toDouble()
          : null,
      images: (json["images"] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
      mnn: json["mnn"],
      mnnLat: json["mnn_lat"],
      name: json["name"],
      description: json["description"],
      code: json["code"],
      dose: json["dose"],
      form: json["form"],
      brand: json["manufacturer"],
      image: image,
      recipe: json["recipe"],
      country: json["country"],
      delivery: json["delivery"],
      price: _parseToInt(json["price"]) ??
          _parseToInt(json["PRICE"]) ??
          _parseToInt(json["original_price"]) ??
          0,
      oldPrice: _parseToInt(json["price_old"]),
      discount: _parseToInt(json["product_price_from_percent"]) ??
          _parseToInt(json["discount_percent"]),
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
      maxCount: _parseToInt(json['maxAmount']),
      utsenkaPrice: json['utsenka_price'] != null
          ? double.tryParse(json['utsenka_price'])
          : null,
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
        "special_offer": specialOffer?.title,
        "bonuses": bonuses,
        "CASHBACK_PERCENT": cashbackPercent,
        "images": images,
        "maxAmount": maxCount,
        "utsenkaPrice": utsenkaPrice,
      }
    };
  }

  ProductModel copyWith({
    int? productId,
    String? offerId,
    int? maxCount,
    int? bonuses,
    double? cashbackPercent,
    int? valueBuy,
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
    TypeOfSpecialOffer? specialOffer,
    bool? availableForDelivery,
    List<String>? images,
    bool? isFav,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      offerId: offerId ?? this.offerId,
      maxCount: maxCount ?? this.maxCount,
      bonuses: bonuses ?? this.bonuses,
      cashbackPercent: cashbackPercent ?? this.cashbackPercent,
      valueBuy: valueBuy ?? this.valueBuy,
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
      specialOffer: specialOffer ?? this.specialOffer,
      availableForDelivery: availableForDelivery ?? this.availableForDelivery,
      images: images ?? this.images,
    );
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
