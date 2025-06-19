import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/order_delivery_personal_data_screen/order_delivery_personal_data_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/order_delivery_personal_data_screen/order_delivery_form_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderDeliveryPersonalDataScreen extends StatefulWidget {
  const OrderDeliveryPersonalDataScreen({super.key});

  @override
  State<OrderDeliveryPersonalDataScreen> createState() =>
      _OrderDeliveryPersonalDataScreenState();
}

class _OrderDeliveryPersonalDataScreenState
    extends State<OrderDeliveryPersonalDataScreen> {
  late OrderDeliveryPersonalDataBloc personalDataBloc;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    personalDataBloc = OrderDeliveryPersonalDataBloc(getMeUC: sl())
      ..add(GetPersonalDataEvent());
    _addListeners();
  }

  void _addListeners() {
    final controllers = [
      personalDataBloc.fNameController,
      personalDataBloc.sNameController,
      personalDataBloc.cityController,
      personalDataBloc.districtAndBuildingController,
      personalDataBloc.entranceController,
      personalDataBloc.floorController,
      personalDataBloc.apartmentController,
    ];

    for (var controller in controllers) {
      controller.addListener(_validateFields);
    }
  }

  void _validateFields() {
    final areFilled = personalDataBloc.fNameController.text.isNotEmpty &&
        personalDataBloc.sNameController.text.isNotEmpty &&
        personalDataBloc.cityController.text.isNotEmpty &&
        personalDataBloc.districtAndBuildingController.text.isNotEmpty &&
        personalDataBloc.entranceController.text.isNotEmpty &&
        personalDataBloc.floorController.text.isNotEmpty &&
        personalDataBloc.apartmentController.text.isNotEmpty;

    if (areFilled != isButtonEnabled) {
      setState(() {
        isButtonEnabled = areFilled;
      });
    }
  }

  @override
  void dispose() {
    personalDataBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: personalDataBloc,
      child: BlocBuilder<OrderDeliveryPersonalDataBloc,
          OrderDeliveryPersonalDataState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: UiConstants.backgroundColor,
            body: SafeArea(
              child: Skeletonizer(
                ignorePointers: false,
                enabled: state is OrderDeliveryPersonalDataLoading,
                child: Column(
                  children: [
                    CustomAppBar(
                      backgroundColor: UiConstants.backgroundColor,
                      title: 'Доставка на дом',
                      showBack: true,
                    ),
                    Expanded(
                      child: ListView(
                        padding: getMarginOrPadding(
                            bottom: 71, right: 20, left: 20, top: 16),
                        children: [
                          OrderDeliveryForm(personalDataBloc: personalDataBloc),
                          SizedBox(height: 16.h),
                          AppButtonWidget(
                            text: 'Оформить доставку',
                            onTap: isButtonEnabled ? () {} : null,
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
