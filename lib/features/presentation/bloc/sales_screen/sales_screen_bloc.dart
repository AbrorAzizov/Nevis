import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/promotion_entity.dart';
import 'package:nevis/features/domain/usecases/main/get_promotions.dart';

part 'sales_screen_event.dart';

part 'sales_screen_state.dart';

class SalesScreenBloc extends Bloc<SalesScreenEvent, SalesScreenState> {
  final GetPromotionsUC getPromotionsUC;
  SalesScreenBloc({
    required this.getPromotionsUC,
})
      : super(
          SalesScreenState(
            promotions: [],
            page: 1,
            lastPage: 1,
            isLoading: false,
            isLoadingFromNextPage: false,
          ),
        ) {
    on<GetPromotionsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await getPromotionsUC.mainRepository.getPromotions();
      result.fold((failure) {
        emit(state.copyWith(isLoading: false));
      }, (result) {
        emit(state.copyWith(promotions: result.$1, lastPage: result.$2, isLoading: false,));
      });
    });

    on<GetPromotionsEventFromNextPage>((event, emit) async {
      if(state.page < state.lastPage && state.isLoadingFromNextPage != true) {
        emit(state.copyWith(isLoadingFromNextPage: true));
        final result = await getPromotionsUC.mainRepository.getPromotions(page: state.page + 1);
        result.fold((failure) {
          emit(state.copyWith(isLoadingFromNextPage: false));
        }, (result) {
          List<PromotionEntity> promotions = [...state.promotions];
          promotions.addAll(result.$1);
          emit(state.copyWith(isLoadingFromNextPage: false, promotions: promotions, page: state.page + 1));
        });
      }
    });
  }
}
