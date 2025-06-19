import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/usecases/profile/get_me.dart';

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
  OrderDeliveryPersonalDataBloc({required this.getMeUC})
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
