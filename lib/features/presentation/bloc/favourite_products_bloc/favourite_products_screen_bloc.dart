import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favourite_products_screen_event.dart';
part 'favourite_products_screen_state.dart';

class FavouriteProductsScreenBloc extends Bloc<FavouriteProductsScreenEvent, FavouriteProductsScreenState> {
  FavouriteProductsScreenBloc() : super(FavouriteProductsScreenInitial()) {
    on<FavouriteProductsScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
