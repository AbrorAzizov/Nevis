import 'dart:ui';

import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';

extension StringExtensions on String? {
  String orDash() {
    return (this == null || this!.isEmpty) ? '-' : this!;
  }
}

extension OrderStatusExtension on OrderStatus {
  static const Map<OrderStatus, String> titles = {
    OrderStatus.onTheWay: 'В пути',
    OrderStatus.readyToIssue: 'Готов к выдаче',
    OrderStatus.reserved: 'Зарезервирован',
    OrderStatus.canceled: 'Заказ отменен',
    OrderStatus.received: 'Получен',
    OrderStatus.collected: 'Собран',
    OrderStatus.collecting: 'В обработке',
    OrderStatus.accepted: 'Принят'
  };

  String get title => titles[this] ?? 'Неизвестный статус';

  static OrderStatus? fromTitle(String? title) {
    return titles.entries
        .firstWhere(
          (entry) => entry.value == title,
          orElse: () =>
              const MapEntry(OrderStatus.collecting, ''), // обработка ошибки
        )
        .key;
  }
}

extension TypeReceivingExtension on TypeReceiving {
  static const Map<TypeReceiving, String> titles = {
    TypeReceiving.delivery: 'Доставка',
    TypeReceiving.pickup: 'Самовывоз',
  };

  String get title => titles[this] ?? 'Неизвестный способ получения';

  static TypeReceiving? fromTitle(String? title) {
    return titles.entries
        .firstWhere(
          (entry) => entry.value == title,
          orElse: () =>
              const MapEntry(TypeReceiving.delivery, ''), // обработка ошибки
        )
        .key;
  }
}

extension ProductCategoriesExtension on ProductCategories {
  static const Map<ProductCategories, String> titles = {
    ProductCategories.hygiene: 'Средства гигены',
    ProductCategories.cosmetic: 'Косметика и уход',
    ProductCategories.medicines: 'Лекарства и БАДы',
    ProductCategories.motherAndBaby: 'Мама и малыш',
    ProductCategories.medicineTools: 'Медицинские приборы',
    ProductCategories.optic: 'Оптика',
    ProductCategories.orthopedic: 'Ортопедический салон',
    ProductCategories.sport: 'Спорт и фитнес'
  };

  String get title => titles[this] ?? 'Неизвестный способ получения';

  static ProductCategories? fromTitle(String? title) {
    return titles.entries
        .firstWhere(
          (entry) => entry.value == title,
          orElse: () => MapEntry(ProductCategories.hygiene, 'Средства гигены'),
        )
        .key;
  }

  String get categoryImagePath {
    switch (this) {
      case ProductCategories.hygiene:
        return Paths.hygieneIconPath;
      case ProductCategories.cosmetic:
        return Paths.cosmeticIconPath;
      case ProductCategories.medicineTools:
        return Paths.medicineToolsIconPath;
      case ProductCategories.optic:
        return Paths.opticIconPaths;
      case ProductCategories.motherAndBaby:
        return Paths.motherAndBabyIconPath;
      case ProductCategories.sport:
        return Paths.sportIconPath;
      case ProductCategories.medicines:
        return Paths.medicinesIconPath;
      case ProductCategories.orthopedic:
        return Paths.orthopedicIconPath;
    }
  }
}

extension PaymentTypeExtension on PaymentType {
  static const Map<PaymentType, String> titles = {
    PaymentType.inPerson: 'Наличными',
    PaymentType.online: 'Онлайн',
  };

  String get title => titles[this] ?? 'Неизвестный способ оплаты';

  static PaymentType? fromTitle(String? title) {
    return title == titles[PaymentType.online]
        ? PaymentType.online
        : PaymentType.inPerson;
  }
}

extension ProductSortTypeExtension on ProductSortType {
  String get displayName {
    switch (this) {
      case ProductSortType.popularity:
        return 'Популярное';
      case ProductSortType.alphabet:
        return 'По алфавиту';
      case ProductSortType.priceDecrease:
        return 'Дороже';
      case ProductSortType.priceIncrease:
        return 'Дешевле';
    }
  }

  static const Map<ProductSortType, String> typeOfSortMap = {
    ProductSortType.alphabet: 'name',
    ProductSortType.popularity: '', // TO DO change to popularity,
    ProductSortType.priceIncrease: 'price',
    ProductSortType.priceDecrease: 'price',
  };
  String get typeOfSort => typeOfSortMap[this] ?? '';
}

extension TypeOfSpecialOfferExtension on TypeOfSpecialOffer {
  static const Map<TypeOfSpecialOffer, String> titles = {
    TypeOfSpecialOffer.onePlusOne: '1+1',
    TypeOfSpecialOffer.onePlusTwo: '2+1',
    TypeOfSpecialOffer.onePlusThree: '3+1',
  };

  static const Map<TypeOfSpecialOffer, int> counts = {
    TypeOfSpecialOffer.onePlusOne: 1,
    TypeOfSpecialOffer.onePlusTwo: 2,
    TypeOfSpecialOffer.onePlusThree: 3,
  };

  String get title => titles[this] ?? 'Неизвестный способ получения';

  int get count => counts[this] ?? 1;

  static TypeOfSpecialOffer? fromTitle(String? title) {
    for (final entry in titles.entries) {
      if (entry.value == title) {
        return entry.key;
      }
    }
    return null;
  }
}

extension AvailabilityCartStatusExtension on AvailabilityCartStatus {
  static const Map<AvailabilityCartStatus, int> _ids = {
    AvailabilityCartStatus.available: 1,
    AvailabilityCartStatus.fromWareHouse: 2,
    AvailabilityCartStatus.partiallyAvailable: 3,
    AvailabilityCartStatus.notAvailable: 4,
  };

  static final Map<AvailabilityCartStatus, Color> _colors = {
    AvailabilityCartStatus.available: UiConstants.greenColor,
    AvailabilityCartStatus.fromWareHouse:
        UiConstants.blueColor.withOpacity(0.8),
    AvailabilityCartStatus.partiallyAvailable: UiConstants.orangeColor,
    AvailabilityCartStatus.notAvailable: UiConstants.black3Color,
  };

  int get id => _ids[this]!;

  static AvailabilityCartStatus? fromId(int? id) {
    if (id == null) return null;
    return _ids.entries
        .firstWhere(
          (entry) => entry.value == id,
          orElse: () => const MapEntry(AvailabilityCartStatus.notAvailable, 4),
        )
        .key;
  }

  static Color? fromStatus(AvailabilityCartStatus? status) {
    if (status == null) return null;
    return _colors[status];
  }
}
