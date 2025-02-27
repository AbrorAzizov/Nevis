import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selector_state.dart';

class SelectorCubit extends Cubit<SelectorState> {
  final int index;
  SelectorCubit({required this.index})
      : super(SelectorState(selectedIndex: index));

  void onSelectorItemTap(int index) {
    emit(SelectorState(selectedIndex: index));
  }
}
