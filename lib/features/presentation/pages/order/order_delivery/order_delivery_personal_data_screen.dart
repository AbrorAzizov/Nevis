import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/order_delivery_personal_data_screen/order_delivery_personal_data_bloc.dart';
import 'package:nevis/features/presentation/pages/order/order_delivery/order_delivery_success_screen.dart';
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
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    personalDataBloc = OrderDeliveryPersonalDataBloc(
        getMeUC: sl(), createOrderForDeliveryUC: sl())
      ..add(GetPersonalDataEvent());
    _addListeners();
  }

  void _addListeners() {
    final controllers = [
      personalDataBloc.fNameController,
      personalDataBloc.sNameController,
      personalDataBloc.cityController,
      personalDataBloc.districtAndBuildingController,
      personalDataBloc.phoneController
    ];

    for (var controller in controllers) {
      controller.addListener(_validateFields);
    }
  }

  void _validateFields() {
    bool validAddress = false;

    if (personalDataBloc.initialGeoObject != null) {
      // если адрес был выбран из подсказов/тапом по карте,
      // а после одно из полей адреса поменялось, то
      // сбрасываем делаем кнопку на форме неактивной
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

    Future.delayed(Duration(milliseconds: 100), () {
      bool validForm = formKey.currentState?.validate() ?? false;
      final areFilled = personalDataBloc.fNameController.text.isNotEmpty &&
          personalDataBloc.sNameController.text.isNotEmpty &&
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

  void _onCreateOrder() {
    // Получаем текущую дату и время для демонстрации
    final now = DateTime.now();
    final dateDelivery =
        '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}';
    final timeDelivery =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    personalDataBloc.add(CreateOrderForDeliveryEvent(
        dateDelivery: dateDelivery, timeDelivery: timeDelivery));
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
          // Показываем индикатор загрузки при создании заказа
          final isLoading = state is OrderDeliveryPersonalDataLoading ||
              state is OrderDeliveryPersonalDataCreating;

          // Обрабатываем успешное создание заказа
          if (state is OrderDeliveryPersonalDataCreated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Здесь можно добавить навигацию на экран успеха или показать диалог
              Navigator.of(context).push(
                Routes.createRoute(
                  const OrderDeliverySuccessScreen(),
                  settings: RouteSettings(
                      name: Routes.orderDeliverySuccessScreen,
                      arguments: {'order': state.deliveryOrder}),
                ),
              );
            });
          }

          // Обрабатываем ошибку создания заказа
          if (state is OrderDeliveryPersonalDataCreatingFailed) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }

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
                      title: 'Доставка на дом',
                      showBack: true,
                    ),
                    Expanded(
                      child: ListView(
                        padding: getMarginOrPadding(
                            bottom: 71, right: 20, left: 20, top: 16),
                        children: [
                          Form(
                              key: formKey,
                              child: OrderDeliveryForm(
                                  personalDataBloc: personalDataBloc)),
                          SizedBox(height: 16.h),
                          AppButtonWidget(
                            text: state is OrderDeliveryPersonalDataCreating
                                ? 'Создание заказа...'
                                : 'Оформить доставку',
                            onTap: isButtonEnabled && !isLoading
                                ? _onCreateOrder
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
