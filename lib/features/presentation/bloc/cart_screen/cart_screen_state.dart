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

  const CartScreenState({
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
    TypeReceiving? selectorIndex,
    List<ProductEntity>? products,
    List<ProductEntity>? cartProducts,
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
  }) {
    return CartScreenState(
        selectorIndex: selectorIndex ?? this.selectorIndex,
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
        counters: counters ?? this.counters,
        paymentType: paymentType ?? this.paymentType,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [
        cartProducts,
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
        selectorIndex
      ];
}
