import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';

class DeliveryAddressBlock extends StatelessWidget {
  const DeliveryAddressBlock(
      {super.key,
      required this.screenContext,
      required this.onPickAddressOnMap});

  final BuildContext screenContext;
  final Function() onPickAddressOnMap;

  @override
  Widget build(BuildContext context) {
    final cartBloc = screenContext.read<CartScreenBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '2. Адрес',
          style:
              UiConstants.textStyle5.copyWith(color: UiConstants.darkBlueColor),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: getMarginOrPadding(all: 16),
          decoration: BoxDecoration(
            color: UiConstants.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              AppTextFieldWidget(
                  title: 'Город',
                  actionTitle: 'Выбрать на карте',
                  onTapActionTitle: onPickAddressOnMap,
                  hintText: 'Укажите город',
                  controller: cartBloc.cityController),
              SizedBox(height: 24.h),
              AppTextFieldWidget(
                  title: 'Улица, дом',
                  hintText: 'Укажите адрес',
                  controller: cartBloc.streetHomeController),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: AppTextFieldWidget(
                        title: 'Подъезд',
                        hintText: 'Не указано',
                        controller: cartBloc.entranceController),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppTextFieldWidget(
                        title: 'Этаж',
                        hintText: 'Не указано',
                        controller: cartBloc.floorController),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: AppTextFieldWidget(
                        title: 'Квартира',
                        hintText: 'Не указано',
                        controller: cartBloc.flatController),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppTextFieldWidget(
                        title: 'Домофон',
                        hintText: 'Не указано',
                        controller: cartBloc.doorPhoneController),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              AppTextFieldWidget(
                  title: 'Комментарий к заказу',
                  hintText: 'Укажите, что необходимо учесть при доставке',
                  controller: cartBloc.commentController,
                  minLines: 4)
            ],
          ),
        ),
      ],
    );
  }
}
