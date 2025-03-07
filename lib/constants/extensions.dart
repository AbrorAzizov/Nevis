

import 'package:nevis/constants/enums.dart';

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
    OrderStatus.canceled: 'Отменен',
    OrderStatus.received: 'Получен',
    OrderStatus.collected: 'Собран',
    OrderStatus.collecting: 'В cборке',
    OrderStatus.awaitingPayment: 'Ожидает оплаты',
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
    TypeReceiving.all: 'Все',
    TypeReceiving.delivery: 'Доставка',
    TypeReceiving.pickup: 'Самовывоз',
  };

  String get title => titles[this] ?? 'Неизвестный способ получения';

  static TypeReceiving? fromTitle(String? title) {
    return title == titles[TypeReceiving.delivery]
        ? TypeReceiving.delivery
        : TypeReceiving.pickup;
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
