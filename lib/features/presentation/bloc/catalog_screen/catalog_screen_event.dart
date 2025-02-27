part of 'catalog_screen_bloc.dart';

abstract class CatalogScreenEvent extends Equatable {
  const CatalogScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadCategoriesEvent extends CatalogScreenEvent {}
