import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_radio_button.dart';
import 'package:nevis/features/presentation/widgets/personal_data_screen/contacts_block.dart';
import 'package:nevis/features/presentation/widgets/personal_data_screen/date_birthday_widget.dart';

class GeneralInformationBlock extends StatelessWidget {
  const GeneralInformationBlock({super.key, required this.screenContext});

  final BuildContext screenContext;

  @override
  Widget build(BuildContext context) {
    final personalDataBloc = screenContext.read<PersonalDataScreenBloc>();
    final selectedDate = personalDataBloc.state.birthday;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFieldWidget(
            textStyle: UiConstants.textStyle11,
            fillColor: UiConstants.whiteColor,
            title: 'Имя',
            hintText: 'Введите имя',
            controller: personalDataBloc.fNameController),
        SizedBox(height: 16.h),
        AppTextFieldWidget(
            textStyle: UiConstants.textStyle11,
            fillColor: UiConstants.whiteColor,
            title: 'Фамилия',
            hintText: 'Не указано',
            controller: personalDataBloc.sNameController),
        SizedBox(height: 16.h),
        DateBirthdayWidget(
          selectedDate: selectedDate,
          onSelectedDate: (date) => personalDataBloc.add(
            ChangeBirthdayEvent(date),
          ),
        ),
        SizedBox(height: 16.h),
        ContactsBlock(screenContext: screenContext),
        SizedBox(height: 16.h),
        Text('Пол', style: UiConstants.textStyle11),
        SizedBox(height: 8.h),
        Row(
          children: [
            CustomRadioButton(
              title: 'Мужской',
              value: GenderType.M,
              groupValue: personalDataBloc.state.gender,
              onChanged: (value) => personalDataBloc.add(
                ChangeGenderEvent(GenderType.M),
              ),
            ),
            SizedBox(width: 24.w),
            CustomRadioButton(
              title: 'Женский',
              value: GenderType.F,
              groupValue: personalDataBloc.state.gender,
              onChanged: (value) => personalDataBloc.add(
                ChangeGenderEvent(GenderType.F),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
