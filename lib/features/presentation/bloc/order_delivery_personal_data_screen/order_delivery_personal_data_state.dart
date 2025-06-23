part of 'order_delivery_personal_data_bloc.dart';

class OrderDeliveryPersonalDataState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class OrderDeliveryPersonalDataInitial extends OrderDeliveryPersonalDataState {}

class OrderDeliveryPersonalDataLoaded extends OrderDeliveryPersonalDataState {}

class OrderDeliveryPersonalDataLoading extends OrderDeliveryPersonalDataState {}

class OrderDeliveryPersonalDataLoadingFailed
    extends OrderDeliveryPersonalDataState {}

class OrderDeliveryPersonalDataCreating
    extends OrderDeliveryPersonalDataState {}

class OrderDeliveryPersonalDataCreated extends OrderDeliveryPersonalDataState {
  final DeliveryOrderEntity deliveryOrder;

  OrderDeliveryPersonalDataCreated({required this.deliveryOrder});

  @override
  List<Object?> get props => [deliveryOrder];
}

class OrderDeliveryPersonalDataCreatingFailed
    extends OrderDeliveryPersonalDataState {
  final String errorMessage;

  OrderDeliveryPersonalDataCreatingFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
