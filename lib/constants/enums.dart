enum LoginScreenType { login, accountExists ,logInWithMessage, logInWithCalls,logInWithYandex}

enum SelectRegionScreenType { signUp, main }

enum CodeScreenType {signUp, reset,logInWithMessage, logInWithCall }

enum ProductChipType { hit, seasonalOffer, stock, nova }

enum TypeReceiving { all, delivery, pickup }

enum PaymentType { inPerson, online }

enum PharmacyProductsAvailability { partially, fully }

enum ProductsListScreenType { cart, pharmacy, order }

enum PharmacyListScreenType { cart, product }

enum OrderStatus {
  onTheWay, // У курьера
  readyToIssue, // Готов к выдаче
  reserved, // Зарезервирован
  canceled, // Отменен
  received, // Получен
  collected, // Собран
  collecting, // В сборке 
  courierSearching, 
  courierWaiting,// Поиск курьера
  awaitingPayment,
}

enum DeliveryZoneType { green, yellow }

enum ProductSortType { popularity, priceDecrease, priceIncrease }

enum GenderType { male, female }
