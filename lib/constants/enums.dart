enum LoginScreenType {
  login,
  accountExists,
  logInWithMessage,
  logInWithCalls,
  logInWithYandex
}

enum SelectRegionScreenType { signUp, main }

enum CodeScreenType { signUp, reset, logInWithMessage, logInWithCall }

enum ProductChipType { hit, seasonalOffer, stock, nova }

enum TypeReceiving { delivery, pickup, all }

enum PaymentType { inPerson, online }

enum PharmacyProductsAvailability { partially, fully }

enum ProductsListScreenType { cart, pharmacy, order }

enum PharmacyListScreenType { cart, product }

enum ProductCategories {
  hygiene,
  cosmetic,
  medicines,
  motherAndBaby,
  medicineTools,
  optic,
  orthopedic,
  sport
}

enum OrderStatus {
  onTheWay, // У курьера
  readyToIssue, // Готов к выдаче
  reserved, // Зарезервирован
  canceled, // Отменен
  received, // Получен
  collected, // Собран
  collecting, // В сборке
  courierSearching, // поиск курьера
  courierWaiting, // Поиск курьера
  accepted,
}

enum DeliveryZoneType { green, yellow }

enum ProductSortType { popularity, priceDecrease, priceIncrease, alphabet }

enum ProductFilterOrSortType { sort, filter }

enum GenderType { male, female }

enum BonusCardType { physical, virtual }

enum TypeOfSpecialOffer { onePlusOne, onePlusTwo, onePlusThree }

enum LoginServiceType { yandex, vk }

enum PharmacyCardInfoType { yandex, vk }

enum AvailabilityCartStatus {
  available,
  fromWareHouse,
  partiallyAvailable,
  notAvailable,
}

enum PharmacyMapType {
  valueBuyMap,
  orderPickupMap,
  favrotiePharmaciesMap,
  defaultMap,
}

enum CartType { defaultCart, pickupCart }

enum PharmacyProductsAvailabilityType { available, notAvailable }
