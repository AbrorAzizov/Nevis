import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'value_buy_successfully_ordered_screen_event.dart';
part 'value_buy_successfully_ordered_screen_state.dart';

class ValueBuySuccessfullyOrderedScreenBloc extends Bloc<ValueBuySuccessfullyOrderedScreenEvent, ValueBuySuccessfullyOrderedScreenState> {
  ValueBuySuccessfullyOrderedScreenBloc() : super(ValueBuySuccessfullyOrderedScreenInitial()) {
    on<ValueBuySuccessfullyOrderedScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
