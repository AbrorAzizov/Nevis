import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sales_screen_event.dart';
part 'sales_screen_state.dart';

class SalesScreenBloc extends Bloc<SalesScreenEvent, SalesScreenState> {
  SalesScreenBloc()
      : super(
          SalesScreenState(
              categories: ['Все', 'Акции августа', 'Акции июля', 'Скидка 25%'],
              currentCategoryIndex: 0),
        ) {
    on<ChangeCategoryEvent>((event, emit) async {
      emit(state.copyWith(currentCategoryIndex: event.categoryId));
    });
  }
}
