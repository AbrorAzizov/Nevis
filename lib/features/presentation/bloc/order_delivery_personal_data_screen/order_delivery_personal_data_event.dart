part of 'order_delivery_personal_data_bloc.dart';

abstract class OrderDeliveryPersonalDataEvent extends Equatable {
  const OrderDeliveryPersonalDataEvent();

  @override
  List<Object?> get props => [];
}

class GetPersonalDataEvent extends OrderDeliveryPersonalDataEvent {}
