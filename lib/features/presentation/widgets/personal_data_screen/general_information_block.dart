import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/formatters/date_input_formatter.dart';
import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_radio_button.dart';

class GeneralInformationBlock extends StatelessWidget {
  const GeneralInformationBlock({super.key, required this.screenContext});

  final BuildContext screenContext;

  @override
  Widget build(BuildContext context) {
    final personalDataBloc = screenContext.read<PersonalDataScreenBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Общая информация',
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
                  controller: personalDataBloc.fNameController),
              SizedBox(height: 24.h),
              AppTextFieldWidget(
                  title: 'Фамилия',
                  hintText: 'Введите фамилию',
                  controller: personalDataBloc.sNameController),
              SizedBox(height: 24.h),
              AppTextFieldWidget(
                title: 'Дата рождения',
                hintText: 'ДД / ММ / ГГГГ',
                controller: personalDataBloc.birthdayController,
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DateInputFormatter()
                ],
                suffixWidget: Padding(
                  padding: getMarginOrPadding(top: 10, bottom: 10),
                  child: SvgPicture.asset(Paths.calendarIconPath),
                ),
                onChangedField: (p0) =>
                    personalDataBloc.birthdayController.text = p0,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  CustomRadioButton(
                    title: 'Мужской',
                    value: GenderType.male,
                    groupValue: personalDataBloc.state.gender,
                    onChanged: () => personalDataBloc.add(
                      ChangeGenderEvent(GenderType.male),
                    ),
                  ),
                  SizedBox(width: 24.w),
                  CustomRadioButton(
                    title: 'Женский',
                    value: GenderType.female,
                    groupValue: personalDataBloc.state.gender,
                    onChanged: () => personalDataBloc.add(
                      ChangeGenderEvent(GenderType.female),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
