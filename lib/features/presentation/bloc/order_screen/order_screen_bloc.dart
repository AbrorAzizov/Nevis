import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/data/models/order_model.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/usecases/orders/get_one_order.dart';

part 'order_screen_event.dart';
part 'order_screen_state.dart';

class OrderScreenBloc extends Bloc<OrderScreenEvent, OrderScreenState> {
  final GetOneOrderUC getOneOrderUC;
  OrderScreenBloc({required this.getOneOrderUC}) : super(OrderScreenState()) {
    on<LoadDataEvent>(_onLoadData);

    
  }

  void _onLoadData(LoadDataEvent event, Emitter<OrderScreenState> emit) async {
    if (event.orderId == null) {
      emit(
        state.copyWith(isLoading: false, error: 'Ошибка загрузки данных'),
      );
    } else {
      final failureOrLoads = await getOneOrderUC(event.orderId!);

      failureOrLoads.fold(
        (_) => emit(
          state.copyWith(isLoading: false, error: 'Ошибка загрузки данных'),
        ),
        (orderData) => emit(
          state.copyWith(error: null, isLoading: false, order: orderData),
        ),
      );
    }
  }
   
 
}
