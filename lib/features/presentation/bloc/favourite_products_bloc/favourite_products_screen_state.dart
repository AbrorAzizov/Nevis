part of 'favourite_products_screen_bloc.dart';

sealed class FavouriteProductsScreenState extends Equatable {
  const FavouriteProductsScreenState();
  
  @override
  List<Object> get props => [];
}

final class FavouriteProductsScreenInitial extends FavouriteProductsScreenState {}
