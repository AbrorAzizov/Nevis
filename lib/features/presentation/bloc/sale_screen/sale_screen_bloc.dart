import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';

import '../../../domain/usecases/promotion/get_promotion.dart';

part 'sale_screen_event.dart';

part 'sale_screen_state.dart';

class SaleScreenBloc extends Bloc<SaleScreenEvent, SaleScreenState> {
  final GetPromotionUC getPromotionUC;

  SaleScreenBloc({required this.getPromotionUC})
      : super(
          SaleScreenState(),
        ) {
    on<GetPromotionEvent>(_getPromotion);
  }

  Future _getPromotion(
      GetPromotionEvent event, Emitter<SaleScreenState> emit) async {
    if (event.promotionId != null) {
      emit(state.copyWith(isLoading: true));
      final data = await getPromotionUC(event.promotionId!);
      data.fold(
        (_) {
          emit(state.copyWith(isLoading: false));
        },
        (result) {
          PromotionEntity? promotion = result;
          emit(
            state.copyWith(
              isLoading: false,
              promotion: promotion,
            ),
          );
        },
      );
    }
  }
}
