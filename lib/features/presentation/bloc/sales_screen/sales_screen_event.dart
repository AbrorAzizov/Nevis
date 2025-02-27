part of 'sales_screen_bloc.dart';

abstract class SalesScreenEvent extends Equatable {
  const SalesScreenEvent();

  @override
  List<Object> get props => [];
}

class ChangeCategoryEvent extends SalesScreenEvent {
  final int categoryId;
  const ChangeCategoryEvent(this.categoryId);
}
