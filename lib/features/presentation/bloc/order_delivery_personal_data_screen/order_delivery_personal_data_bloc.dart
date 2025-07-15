import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/params/delivery_order_params.dart';
import 'package:nevis/features/data/models/adress_model.dart';
import 'package:nevis/features/domain/entities/delivery_order_entity.dart';
import 'package:nevis/features/domain/usecases/adress/get_delivery_adress.dart';
import 'package:nevis/features/domain/usecases/adress/update_delivery_adress.dart';
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
 bool? _hadInitialAddress;

  bool get hadInitialAddress => _hadInitialAddress ?? true;
  final GetMeUC getMeUC;
  final GetDeliveryAdressUC getDeliveryAdressUC;
    final UpdateDeliveryAdressUC updateDeliveryAdressUC;
  final CreateOrderForDeliveryUC createOrderForDeliveryUC;

  GeoObject? initialGeoObject;

  OrderDeliveryPersonalDataBloc(
      {required this.getMeUC,
      required this.updateDeliveryAdressUC,

      required this.getDeliveryAdressUC, required this.createOrderForDeliveryUC})
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
      

        emit(OrderDeliveryPersonalDataLoaded());
      });
    });

   on<GetDeliveryAdressEvent>((event, emit) async {
  emit(OrderDeliveryPersonalDataLoading());
  final failureOrLoads = await getDeliveryAdressUC();

  failureOrLoads.fold(
    (_) {
      emit(OrderDeliveryPersonalDataLoadingFailed());
      _hadInitialAddress = false;
    },
    (adress) {
      _hadInitialAddress = true;
      cityController.text = adress.city ?? '';
      entranceController.text = adress.entrance ?? '';
      floorController.text = adress.floor ?? '';
      apartmentController.text = adress.apartment ?? '';
      intercomController.text = adress.intercom ?? '';
      districtAndBuildingController.text = adress.street ?? '';
      emit(OrderDeliveryPersonalDataLoaded());
    },
  );
});
     on<UpdateDeliveryAdressEvent>((event, emit) async {
      emit(OrderDeliveryPersonalDataLoading());
      final failureOrLoads = await updateDeliveryAdressUC(AdressModel(
        city: cityController.text,
        street: districtAndBuildingController.text,
        apartment: apartmentController.text,
        entrance: entranceController.text,
        floor: floorController.text,
        intercom: intercomController.text,
      ));

      failureOrLoads.fold((_) => emit(OrderDeliveryPersonalDataLoadingFailed()),
          (_) {
            
          add(GetDeliveryAdressEvent());

       
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
