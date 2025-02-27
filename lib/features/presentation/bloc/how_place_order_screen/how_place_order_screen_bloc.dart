import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'how_place_order_screen_event.dart';
part 'how_place_order_screen_state.dart';

class HowPlaceOrderScreenBloc
    extends Bloc<HowPlaceOrderScreenEvent, HowPlaceOrderScreenState> {
  HowPlaceOrderScreenBloc() : super(HowPlaceOrderScreenInitial());
}
