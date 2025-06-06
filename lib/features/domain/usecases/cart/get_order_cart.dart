import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/cart_for_selected_pharmacy_param.dart';
import 'package:nevis/core/usecases/usecase.dart';
import 'package:nevis/features/domain/entities/order_cart_entity.dart';
import 'package:nevis/features/domain/repositories/cart_repository.dart';

class GetOrderCartProductsUC
    extends UseCaseParam<OrderCartEntity, CartForSelectedPharmacyParam> {
  final CartRepository cartRepository;

  GetOrderCartProductsUC(this.cartRepository);

  @override
  Future<Either<Failure, OrderCartEntity>> call(
      CartForSelectedPharmacyParam params) async {
    return await cartRepository.getCartForSelectedPharmacyProducts(params);
  }
}
