import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/formatters/custom_phone_input_formatter.dart';
import 'package:nevis/features/presentation/bloc/order_delivery_personal_data_screen/order_delivery_personal_data_bloc.dart';
import 'package:nevis/features/presentation/pages/order/order_delivery/pick_address_field_on_map_widget.dart';
import 'package:nevis/features/presentation/pages/order/order_delivery/pick_address_map_screen.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class OrderDeliveryForm extends StatelessWidget {
  final OrderDeliveryPersonalDataBloc personalDataBloc;

  const OrderDeliveryForm({super.key, required this.personalDataBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFieldWidget(
          textStyle: UiConstants.textStyle11,
          fillColor: UiConstants.whiteColor,
          title: 'Имя',
          hintText: 'Введите имя',
          controller: personalDataBloc.fNameController,
        ),
        SizedBox(height: 16.h),
        AppTextFieldWidget(
          textStyle: UiConstants.textStyle11,
          fillColor: UiConstants.whiteColor,
          title: 'Фамилия',
          hintText: 'Не указано',
          controller: personalDataBloc.sNameController,
        ),
        SizedBox(height: 16.h),
        AppTextFieldWidget(
          textStyle: UiConstants.textStyle11,
          fillColor: UiConstants.whiteColor,
          title: 'Телефон',
          hintText: '+7 (900) 000-00-00',
          controller: personalDataBloc.phoneController,
          keyboardType: TextInputType.phone,
          validator: Utils.phoneValidate,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CustomPhoneInputFormatter()
          ],
        ),
        SizedBox(height: 16.h),
        AppTextFieldWidget(
          actionTitle: 'Выбрать адрес на карте',
          textStyle: UiConstants.textStyle11,
          fillColor: UiConstants.whiteColor,
          title: 'Город',
          hintText: 'Не указано',
          controller: personalDataBloc.cityController,
          onTapActionTitle: () async {
            final GeoObject? geoObject =
                await Navigator.of(context).push<GeoObject?>(
              MaterialPageRoute(
                builder: (_) => PickAddressMapScreen(
                    initialGeoObject: personalDataBloc.initialGeoObject),
              ),
            );

            if (geoObject != null) {
              personalDataBloc.add(UpdateAddressEvent(geoObject: geoObject));
            }
          },
        ),
        SizedBox(height: 16.h),
        PickAddressWithSuggestionsField(
          value: [
            personalDataBloc.cityController.text,
            personalDataBloc.districtAndBuildingController.text
          ].join(', '),
          addressController: personalDataBloc.districtAndBuildingController,
          title: 'Улица, дом',
          hintText: 'Не указано',
          hasSearchWidget: false,
          onPickSuggestionObject: (geoObject) {
            if (geoObject != null) {
              personalDataBloc.add(UpdateAddressEvent(geoObject: geoObject));
            }
          },
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: AppTextFieldWidget(
                textStyle: UiConstants.textStyle11,
                fillColor: UiConstants.whiteColor,
                title: 'Подъезд',
                hintText: 'Не указано',
                controller: personalDataBloc.entranceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: AppTextFieldWidget(
                textStyle: UiConstants.textStyle11,
                fillColor: UiConstants.whiteColor,
                title: 'Этаж',
                hintText: 'Не указано',
                controller: personalDataBloc.floorController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: AppTextFieldWidget(
                textStyle: UiConstants.textStyle11,
                fillColor: UiConstants.whiteColor,
                title: 'Квартира',
                hintText: 'Не указано',
                controller: personalDataBloc.apartmentController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: AppTextFieldWidget(
                textStyle: UiConstants.textStyle11,
                fillColor: UiConstants.whiteColor,
                title: 'Домофон',
                hintText: 'Не указано',
                controller: personalDataBloc.intercomController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        AppTextFieldWidget(
          textStyle: UiConstants.textStyle11,
          fillColor: UiConstants.whiteColor,
          title: 'Комментарий к заказу',
          hintText: 'Не указано',
          controller: personalDataBloc.commentController,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
