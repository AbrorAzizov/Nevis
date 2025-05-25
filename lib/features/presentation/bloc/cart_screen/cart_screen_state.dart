part of 'cart_screen_bloc.dart';

class CartScreenState extends Equatable {
  final List<ProductEntity> cartProducts;
  final List<ProductEntity> products;
  final Set<int> selectedProductIds;
  final bool isAllProductsChecked;
  final List<PharmacyEntity> pharmacies;
  final List<PharmacyEntity> filteredPharmacies;
  final int? selectedPharmacy;
  final bool isShowPharmaciesWorkingNow;
  final bool isShowPharmaciesProductsInStock;
  final List<int> promoCodes;
  final TypeReceiving cartType;
  final PaymentType paymentType;
  final String? errorMessage;
  final bool isLoading;
  final Map<int, int> counters;
  final TypeReceiving selectorIndex;
  final double? totalPrice;
  final double? totalDiscounts;
  final int? totalBonuses;
  final bool? deliveryAvailable;

  const CartScreenState({
    this.totalPrice,
    this.totalDiscounts,
    this.totalBonuses,
    this.deliveryAvailable,
    this.products = const [],
    this.selectorIndex = TypeReceiving.delivery,
    this.isLoading = true,
    this.counters = const {},
    this.errorMessage,
    this.cartProducts = const [],
    required this.selectedProductIds,
    required this.isAllProductsChecked,
    required this.pharmacies,
    required this.filteredPharmacies,
    this.selectedPharmacy,
    required this.isShowPharmaciesWorkingNow,
    required this.isShowPharmaciesProductsInStock,
    required this.promoCodes,
    required this.cartType,
    required this.paymentType,
  });

  CartScreenState copyWith({
    List<ProductEntity>? cartProducts,
    List<ProductEntity>? products,
    Set<int>? selectedProductIds,
    bool? isAllProductsChecked,
    List<PharmacyEntity>? pharmacies,
    List<PharmacyEntity>? filteredPharmacies,
    int? selectedPharmacy,
    bool? isShowPharmaciesWorkingNow,
    bool? isShowPharmaciesProductsInStock,
    List<int>? promoCodes,
    TypeReceiving? cartType,
    PaymentType? paymentType,
    String? errorMessage,
    bool? isLoading,
    Map<int, int>? counters,
    TypeReceiving? selectorIndex,
    double? totalPrice,
    double? totalDiscounts,
    int? totalBonuses,
    bool? deliveryAvailable,
  }) {
    return CartScreenState(
      cartProducts: cartProducts ?? this.cartProducts,
      products: products ?? this.products,
      selectedProductIds: selectedProductIds ?? this.selectedProductIds,
      isAllProductsChecked: isAllProductsChecked ?? this.isAllProductsChecked,
      pharmacies: pharmacies ?? this.pharmacies,
      filteredPharmacies: filteredPharmacies ?? this.filteredPharmacies,
      selectedPharmacy: selectedPharmacy ?? this.selectedPharmacy,
      isShowPharmaciesWorkingNow:
          isShowPharmaciesWorkingNow ?? this.isShowPharmaciesWorkingNow,
      isShowPharmaciesProductsInStock: isShowPharmaciesProductsInStock ??
          this.isShowPharmaciesProductsInStock,
      promoCodes: promoCodes ?? this.promoCodes,
      cartType: cartType ?? this.cartType,
      paymentType: paymentType ?? this.paymentType,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
      counters: counters ?? this.counters,
      selectorIndex: selectorIndex ?? this.selectorIndex,
      totalPrice: totalPrice ?? this.totalPrice,
      totalDiscounts: totalDiscounts ?? this.totalDiscounts,
      totalBonuses: totalBonuses ?? this.totalBonuses,
      deliveryAvailable: deliveryAvailable ?? this.deliveryAvailable,
    );
  }

  @override
  List<Object?> get props => [
        cartProducts,
        products,
        selectedProductIds,
        isAllProductsChecked,
        pharmacies,
        filteredPharmacies,
        selectedPharmacy,
        isShowPharmaciesWorkingNow,
        isShowPharmaciesProductsInStock,
        promoCodes,
        cartType,
        paymentType,
        errorMessage,
        isLoading,
        counters,
        selectorIndex,
        totalPrice,
        totalDiscounts,
        totalBonuses,
        deliveryAvailable,
      ];
}
