part of 'order_delivery_personal_data_bloc.dart';

abstract class OrderDeliveryPersonalDataEvent extends Equatable {
  const OrderDeliveryPersonalDataEvent();

  @override
  List<Object?> get props => [];
}

class GetPersonalDataEvent extends OrderDeliveryPersonalDataEvent {}

class GetDeliveryAdressEvent extends OrderDeliveryPersonalDataEvent {}

class UpdateAddressEvent extends OrderDeliveryPersonalDataEvent {
  final GeoObject geoObject;
  const UpdateAddressEvent({required this.geoObject});
}

class UpdateDeliveryAdressEvent extends OrderDeliveryPersonalDataEvent {}

class CreateOrderForDeliveryEvent extends OrderDeliveryPersonalDataEvent {
  final String dateDelivery;
  final String timeDelivery;

  const CreateOrderForDeliveryEvent({
    required this.dateDelivery,
    required this.timeDelivery,
  });
}
