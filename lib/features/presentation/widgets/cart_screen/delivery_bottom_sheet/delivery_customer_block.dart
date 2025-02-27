import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/formatters/custom_phone_input_formatter.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';

class DeliveryCustomerBlock extends StatelessWidget {
  const DeliveryCustomerBlock({super.key, required this.screenContext});

  final BuildContext screenContext;

  @override
  Widget build(BuildContext context) {
    final cartBloc = screenContext.read<CartScreenBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '1. Получатель',
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
                  title: 'Имя',
                  hintText: 'Введите имя',
                  controller: cartBloc.fNameController),
              SizedBox(height: 24.h),
              AppTextFieldWidget(
                  title: 'Фамилия',
                  hintText: 'Введите фамилию',
                  controller: cartBloc.sNameController),
              SizedBox(height: 24.h),
              AppTextFieldWidget(
                title: 'Телефон',
                hintText: '+375 (00) 000-00-00',
                controller: cartBloc.phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CustomPhoneInputFormatter()
                ],
              ),
              SizedBox(height: 24.h),
              AppTextFieldWidget(
                  title: 'Email',
                  description: 'Обязательно при оплате онлайн в приложении',
                  hintText: 'Введите Email',
                  controller: cartBloc.emailController),
            ],
          ),
        ),
      ],
    );
  }
}
