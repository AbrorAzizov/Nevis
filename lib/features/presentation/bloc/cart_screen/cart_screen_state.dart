part of 'cart_screen_bloc.dart';

class CartScreenState extends Equatable {
  final List<ProductEntity> products;
  final Set<int> selectedProductIds;
  final bool isAllProductsChecked;
  final List<Pharmacy> pharmacies;
  final List<Pharmacy> filteredPharmacies;
  final int? selectedPharmacy;
  final bool isShowPharmaciesWorkingNow;
  final bool isShowPharmaciesProductsInStock;
  final List<int> promoCodes;
  final TypeReceiving cartType;
  final PaymentType paymentType;

  const CartScreenState({
    required this.products,
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
    List<ProductEntity>? products,
    Set<int>? selectedProductIds,
    bool? isAllProductsChecked,
    List<Pharmacy>? pharmacies,
    List<Pharmacy>? filteredPharmacies,
    int? selectedPharmacy,
    bool? isShowPharmaciesWorkingNow,
    bool? isShowPharmaciesProductsInStock,
    List<int>? promoCodes,
    TypeReceiving? cartType,
    PaymentType? paymentType,
  }) {
    return CartScreenState(
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
    );
  }

  @override
  List<Object?> get props => [
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
      ];
}
