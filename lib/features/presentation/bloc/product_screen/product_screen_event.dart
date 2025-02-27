part of 'product_screen_bloc.dart';

abstract class ProductScreenEvent extends Equatable {
  const ProductScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends ProductScreenEvent {}
