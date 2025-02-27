import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';

class ChangePasswordBlock extends StatefulWidget {
  const ChangePasswordBlock({super.key, required this.screenContext});

  final BuildContext screenContext;

  @override
  State<ChangePasswordBlock> createState() => _ChangePasswordBlockState();
}

class _ChangePasswordBlockState extends State<ChangePasswordBlock> {
  @override
  Widget build(BuildContext context) {
    final personalDataBloc =
        widget.screenContext.read<PersonalDataScreenBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Изменить пароль',
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
                title: 'Старый пароль',
                hintText: 'Введите пароль',
                isObscuredText: true,
                controller: personalDataBloc.oldPasswordController,
                errorText: personalDataBloc.state.passwordErrorText,
                isShowError:
                    personalDataBloc.oldPasswordController.text.isEmpty &&
                        [
                          personalDataBloc.newPasswordController.text,
                          personalDataBloc.newPasswordConfirmController.text
                        ].any((e) => e.isNotEmpty),
                onChangedField: (_) => setState(() {}),
              ),
              SizedBox(height: 24.h),
              AppTextFieldWidget(
                title: 'Новый пароль',
                hintText: 'Введите пароль',
                isObscuredText: true,
                controller: personalDataBloc.newPasswordController,
                errorText: personalDataBloc.state.passwordErrorText,
                isShowError: personalDataBloc
                            .newPasswordController.text.isEmpty &&
                        personalDataBloc.oldPasswordController.text.isNotEmpty
                    ? true
                    : personalDataBloc.newPasswordController.text.isNotEmpty &&
                            personalDataBloc
                                .newPasswordConfirmController.text.isNotEmpty
                        ? (personalDataBloc.newPasswordController.text !=
                            personalDataBloc.newPasswordConfirmController.text)
                        : false,
                onChangedField: (_) => setState(() {}),
              ),
              SizedBox(height: 24.h),
              AppTextFieldWidget(
                title: 'Подтвердите пароль',
                hintText: 'Введите пароль',
                isObscuredText: true,
                controller: personalDataBloc.newPasswordConfirmController,
                errorText: personalDataBloc.state.passwordErrorText,
                isShowError: (personalDataBloc
                            .oldPasswordController.text.isNotEmpty &&
                        personalDataBloc
                            .newPasswordConfirmController.text.isEmpty)
                    ? true
                    : personalDataBloc.newPasswordController.text.isNotEmpty
                        ? (personalDataBloc.newPasswordController.text !=
                            personalDataBloc.newPasswordConfirmController.text)
                        : false,
                onChangedField: (_) => setState(() {}),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
