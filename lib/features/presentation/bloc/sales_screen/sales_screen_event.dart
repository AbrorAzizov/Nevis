part of 'sales_screen_bloc.dart';

abstract class SalesScreenEvent extends Equatable {
  const SalesScreenEvent();

  @override
  List<Object> get props => [];
}

class GetPromotionsEvent extends SalesScreenEvent {
  const GetPromotionsEvent();
}

class GetPromotionsEventFromNextPage extends SalesScreenEvent {
  const GetPromotionsEventFromNextPage();
}