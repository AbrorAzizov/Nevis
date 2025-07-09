
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/order_delivery_personal_data_screen/order_delivery_personal_data_bloc.dart';
import 'package:nevis/features/presentation/pages/order/order_delivery/order_delivery_personal_data_screen.dart';
import 'package:nevis/features/presentation/pages/order/order_delivery/order_delivery_success_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/delivery_adress_screen/delivery_form.dart';
import 'package:nevis/features/presentation/widgets/order_delivery_personal_data_screen/order_delivery_form_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';
class DeliveryPersonalDataScreen extends StatefulWidget {
  const DeliveryPersonalDataScreen({super.key});

  @override
  State<DeliveryPersonalDataScreen> createState() =>
      DeliveryPersonalDataScreenState();
}

class DeliveryPersonalDataScreenState
    extends State<DeliveryPersonalDataScreen> {
  late OrderDeliveryPersonalDataBloc personalDataBloc;
  bool isButtonEnabled = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    personalDataBloc = OrderDeliveryPersonalDataBloc(
      getDeliveryAdressUC: sl(),
      getMeUC: sl(),
      createOrderForDeliveryUC: sl(), updateDeliveryAdressUC: sl(),
    )..add(GetDeliveryAdressEvent());

    _addListeners();
  }

  void _addListeners() {
    final controllers = [
      personalDataBloc.cityController,
      personalDataBloc.districtAndBuildingController,
    ];

    for (var controller in controllers) {
      controller.addListener(_validateFields);
    }
  }

  void _validateFields() {
    bool validAddress = false;

    if (personalDataBloc.initialGeoObject != null) {
      List<String> fullAddressComponents = [
        personalDataBloc.districtAndBuildingController.text,
        personalDataBloc.cityController.text
      ].join(', ').split(', ');
      List<String> getObjectAddressComponents = (personalDataBloc
                  .initialGeoObject
                  ?.metaDataProperty
                  ?.geocoderMetaData
                  ?.address
                  ?.formatted ??
              '')
          .split(', ');

      List<String> normalize(List<String> list) =>
          list.map((e) => e.trim().toLowerCase()).toList();

      final normalizedFull = normalize(fullAddressComponents);
      final normalizedFromGeo = normalize(getObjectAddressComponents);

      validAddress = normalizedFull.every(
        (item) => normalizedFromGeo.contains(item),
      );
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      bool validForm = formKey.currentState?.validate() ?? false;
      final areFilled =
          personalDataBloc.cityController.text.isNotEmpty &&
          personalDataBloc.districtAndBuildingController.text.isNotEmpty &&
          personalDataBloc.initialGeoObject != null &&
          validForm &&
          validAddress;

      if (areFilled != isButtonEnabled) {
        setState(() {
          isButtonEnabled = areFilled;
        });
      }
    });
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
          final isLoading = state is OrderDeliveryPersonalDataLoading ||
              state is OrderDeliveryPersonalDataCreating;

          return Scaffold(
            backgroundColor: UiConstants.backgroundColor,
            body: SafeArea(
              child: Skeletonizer(
                ignorePointers: false,
                enabled: isLoading,
                child: Column(
                  children: [
                    CustomAppBar(
                      backgroundColor: UiConstants.backgroundColor,
                      title: 'Адрес доставки',
                      showBack: true,
                    ),
                    Expanded(
                      child: ListView(
                        padding: getMarginOrPadding(
                            bottom: 71, right: 20, left: 20, top: 16),
                        children: [
                          Form(
                            key: formKey,
                            child: DeliveryForm(
                              personalDataBloc: personalDataBloc,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          AppButtonWidget(
                            text: isLoading ? 'Сохранение ...' : 'Сохранить',
                            onTap: isButtonEnabled && !isLoading
                                ? () {  
                                  print(personalDataBloc.districtAndBuildingController);
                                  personalDataBloc.add(UpdateDeliveryAdressEvent());
                                } 
                                : null,
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