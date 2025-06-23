import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/params/delivery_order_params.dart';
import 'package:nevis/features/domain/entities/delivery_order_entity.dart';
import 'package:nevis/features/domain/usecases/order/create_order_for_delivery.dart';
import 'package:nevis/features/domain/usecases/profile/get_me.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

part 'order_delivery_personal_data_event.dart';
part 'order_delivery_personal_data_state.dart';

class OrderDeliveryPersonalDataBloc extends Bloc<OrderDeliveryPersonalDataEvent,
    OrderDeliveryPersonalDataState> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController sNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController cityController = TextEditingController();
  final TextEditingController entranceController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController intercomController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController districtAndBuildingController =
      TextEditingController();

  final GetMeUC getMeUC;
  final CreateOrderForDeliveryUC createOrderForDeliveryUC;

  GeoObject? initialGeoObject;

  OrderDeliveryPersonalDataBloc(
      {required this.getMeUC, required this.createOrderForDeliveryUC})
      : super(OrderDeliveryPersonalDataInitial()) {
    on<GetPersonalDataEvent>((event, emit) async {
      emit(OrderDeliveryPersonalDataLoading());
      final failureOrLoads = await getMeUC();

      failureOrLoads.fold((_) => emit(OrderDeliveryPersonalDataLoadingFailed()),
          (profile) {
        fNameController.text = profile.firstName ?? '';
        sNameController.text = profile.lastName ?? '';
        phoneController.text = Utils.formatPhoneNumber(profile.phone,
            format: PhoneNumberFormat.client);
        cityController.text = profile.deliveryAddress?.city ?? '';
        entranceController.text = profile.deliveryAddress?.entrance ?? '';
        floorController.text = profile.deliveryAddress?.floor ?? '';
        apartmentController.text = profile.deliveryAddress?.apartment ?? '';
        intercomController.text = profile.deliveryAddress?.intercom ?? '';
        districtAndBuildingController.text =
            profile.deliveryAddress?.building ?? '';

        emit(OrderDeliveryPersonalDataLoaded());
      });
    });

    on<UpdateAddressEvent>(_onUpdateAddressData);
    on<CreateOrderForDeliveryEvent>(_onCreateOrderForDelivery);
  }

  Future _onUpdateAddressData(
    UpdateAddressEvent event,
    Emitter<OrderDeliveryPersonalDataState> emit,
  ) async {
    // сохраняем результат геокодера
    initialGeoObject = event.geoObject;

    final components = initialGeoObject
            ?.metaDataProperty?.geocoderMetaData?.address?.components ??
        [];

    final city = components
            .firstWhereOrNull((c) => c.kind == KindResponse.locality)
            ?.name ??
        '';

    final street = components
            .firstWhereOrNull((c) => c.kind == KindResponse.street)
            ?.name ??
        '';

    final house = components
            .firstWhereOrNull((c) => c.kind == KindResponse.house)
            ?.name ??
        '';

    cityController.text = city;
    districtAndBuildingController.text = '$street, $house';
  }

  Future _onCreateOrderForDelivery(
    CreateOrderForDeliveryEvent event,
    Emitter<OrderDeliveryPersonalDataState> emit,
  ) async {
    emit(OrderDeliveryPersonalDataCreating());

    // Получаем координаты из геообъекта
    String? lon, lat;
    if (initialGeoObject != null && initialGeoObject!.point != null) {
      lat = initialGeoObject!.point!.latitude?.toString();
      lon = initialGeoObject!.point!.longitude?.toString();
    }

    // Создаем параметры для заказа доставки
    final deliveryParams = DeliveryOrderParams(
      address: initialGeoObject
              ?.metaDataProperty?.geocoderMetaData?.address?.formatted ??
          '',
      dateDelivery: event.dateDelivery,
      timeDelivery: event.timeDelivery,
      orderType: 'delivery',
      lon: lon,
      lat: lat,
    );

    final failureOrSuccess = await createOrderForDeliveryUC(deliveryParams);

    failureOrSuccess.fold(
      (failure) => emit(
        OrderDeliveryPersonalDataCreatingFailed(
            errorMessage: failure.message ?? ''),
      ),
      (deliveryOrder) => emit(OrderDeliveryPersonalDataCreated(
        deliveryOrder: deliveryOrder,
      )),
    );
  }

  @override
  Future<void> close() {
    cityController.dispose();
    entranceController.dispose();
    floorController.dispose();
    apartmentController.dispose();
    intercomController.dispose();
    commentController.dispose();
    return super.close();
  }
}
