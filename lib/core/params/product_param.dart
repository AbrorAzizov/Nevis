import 'package:equatable/equatable.dart';

class ProductParam extends Equatable {
  final int? priceFrom;
  final int? priceTo;
  final List<String>? releaseForm;
  final List<String>? form;
  final List<String>? brand;
  final List<String>? country;
  final String? recipe;
  final bool? action;
  final String? delivery;
  final bool? available;
  final int? perPage;
  final int? page;
  final String? sortBy;
  final int? categoryId;

  const ProductParam({
    this.priceFrom,
    this.priceTo,
    this.releaseForm,
    this.form,
    this.brand,
    this.country,
    this.recipe,
    this.action,
    this.delivery,
    this.available,
    this.perPage,
    this.page,
    this.sortBy,
    this.categoryId,
  });

  @override
  List<Object?> get props => [
        priceFrom,
        priceTo,
        releaseForm,
        form,
        brand,
        country,
        recipe,
        action,
        delivery,
        available,
        perPage,
        page,
        sortBy,
        categoryId,
      ];

  factory ProductParam.fromJson(Map<String, dynamic> json) {
    return ProductParam(
      priceFrom: json['price_from'] as int?,
      priceTo: json['price_to'] as int?,
      releaseForm:
          (json['release_form'] as List?)?.map((e) => e as String).toList(),
      form: (json['form'] as List?)?.map((e) => e as String).toList(),
      brand: (json['brand'] as List?)?.map((e) => e as String).toList(),
      country: (json['country'] as List?)?.map((e) => e as String).toList(),
      recipe: json['recipe'] as String?,
      action: json['action'] as bool?,
      delivery: json['delivery'] as String?,
      available: json['available'] as bool?,
      perPage: json['per_page'] as int?,
      page: json['page'] as int?,
      sortBy: json['sortby'] as String?,
      categoryId: json['category_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'price_from': priceFrom,
      'price_to': priceTo,
      'release_form': releaseForm,
      'form': form,
      'brand': brand,
      'country': country,
      'recipe': recipe,
      'action': action,
      'delivery': delivery,
      'available': available,
      'per_page': perPage,
      'page': page,
      'sortby': sortBy,
      'category_id': categoryId,
    };

    map.removeWhere(
        (key, value) => value == null || (value is List && value.isEmpty));

    return map;
  }

  ProductParam copyWith({
    int? priceFrom,
    int? priceTo,
    List<String>? releaseForm,
    List<String>? form,
    List<String>? brand,
    List<String>? country,
    String? recipe,
    bool? action,
    String? delivery,
    bool? available,
    int? perPage,
    int? page,
    String? sortBy,
    int? categoryId,
  }) {
    return ProductParam(
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
      releaseForm: releaseForm ?? this.releaseForm,
      form: form ?? this.form,
      brand: brand ?? this.brand,
      country: country ?? this.country,
      recipe: recipe ?? this.recipe,
      action: action ?? this.action,
      delivery: delivery ?? this.delivery,
      available: available ?? this.available,
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      sortBy: sortBy ?? this.sortBy,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
