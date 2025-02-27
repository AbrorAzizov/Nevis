part of 'selector_cubit.dart';

class SelectorState extends Equatable {
  final int selectedIndex;

  const SelectorState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
