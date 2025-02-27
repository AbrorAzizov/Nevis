enum LoginScreenType { login, accountExists }

enum SelectRegionScreenType { signUp, main }

enum PasswordScreenType { signUp, reset }

enum ProductChipType { hit, seasonalOffer, stock, nova }

enum TypeReceiving { all, delivery, pickup }

enum PaymentType { courier, online }

enum PharmacyProductsAvailability { partially, fully }

enum ProductsListScreenType { cart, pharmacy, order }

enum PharmacyListScreenType { cart, product }

enum OrderStatus {
  courier, // У курьера
  readyToIssue, // Готов к выдаче
  reserved, // Зарезервирован
  canceled, // Отменен
  received, // Получен
  collected, // Собран
  processing, // В обработке
  awaitingPayment // Ожидает оплаты
}

enum DeliveryZoneType { green, yellow }

enum ProductSortType { popularity, priceDecrease, priceIncrease }

enum GenderType { male, female }
