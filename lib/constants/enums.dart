enum LoginScreenType { login, accountExists ,logInWithMessage, logInWithCalls,logInWithYandex}

enum SelectRegionScreenType { signUp, main }

enum CodeScreenType {signUp, reset,logInWithMessage, logInWithCall }

enum ProductChipType { hit, seasonalOffer, stock, nova }

enum TypeReceiving { all, delivery, pickup, pickupFromWareHouse }

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
  courierSearching, // поиск курьера
  courierWaiting,// Поиск курьера
  accepted,
}

enum DeliveryZoneType { green, yellow }

enum ProductSortType { popularity, priceDecrease, priceIncrease, alphabet }

enum ProductFilterOrSortType {sort, filter}

enum GenderType { male, female }
