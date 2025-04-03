import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/formatters/card_number_formatter.dart';
import 'package:nevis/features/presentation/bloc/register_bonus_card_screen/register_bonus_cardscreen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_radio_button.dart';
import 'package:nevis/features/presentation/widgets/register_bonus_card_screen/contacts_block_bonus_card.dart';

class GeneralInformationBlock extends StatelessWidget {
  const GeneralInformationBlock(
      {super.key, required this.screenContext, required this.cardType});

  final BuildContext screenContext;
  final BonusCardType cardType;

  @override
  Widget build(BuildContext context) {
    final registerBonusCardBloc =
        screenContext.read<RegisterBonusCardScreenBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            cardType == BonusCardType.physical
                ? AppTextFieldWidget(
                    textStyle: UiConstants.textStyle11,
                    fillColor: UiConstants.whiteColor,
                    title: 'Ввидите номер карты',
                    hintText: 'Номер карты',
                    controller: registerBonusCardBloc.cardController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CardNumberFormatter()
                    ],
                    onTapActionTitle: () async {
                      // await context
                      //     .read<CodeScreenBloc>()
                      //     .reset(phone: personalDataBloc.phoneController.text);
                      // context.read<CodeScreenBloc>().startTimer(
                      //   phone: personalDataBloc.phoneController.text,
                      //   widget.screenContext,
                      //   requestCodeFun: () async {
                      //     return await personalDataBloc.updateProfile(
                      //         requestedCode: true);
                      //   },
                      // );
                    },
                  )
                : SizedBox.shrink(),
            AppTextFieldWidget(
                textStyle: UiConstants.textStyle11,
                fillColor: UiConstants.whiteColor,
                title: 'Имя',
                hintText: 'Введите имя',
                controller: registerBonusCardBloc.fNameController),
            SizedBox(height: 16.h),
            AppTextFieldWidget(
                textStyle: UiConstants.textStyle11,
                fillColor: UiConstants.whiteColor,
                title: 'Фамилия',
                hintText: 'Не указано',
                controller: registerBonusCardBloc.sNameController),
            SizedBox(height: 16.h),
            // AppTextFieldWidget(
            //      textStyle: UiConstants.textStyle11,
            //    fillColor: UiConstants.whiteColor,
            //   title: 'Дата рождения',
            //   hintText: 'ДД / ММ / ГГГГ',
            //   controller: personalDataBloc.birthdayController,
            //   keyboardType: TextInputType.datetime,
            //   inputFormatters: [
            //     FilteringTextInputFormatter.digitsOnly,
            //     DateInputFormatter()
            //   ],
            //   suffixWidget: Padding(
            //     padding: getMarginOrPadding(top: 10, bottom: 10),
            //     child: SvgPicture.asset(Paths.calendarIconPath),
            //   ),
            //   onChangedField: (p0) =>
            //       personalDataBloc.birthdayController.text = p0,
            // ),
            ContactsBlock(
              screenContext: screenContext,
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              children: [
                Text(
                  'Пол',
                  style: UiConstants.textStyle11,
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                CustomRadioButton(
                  title: 'Мужской',
                  value: GenderType.male,
                  groupValue: registerBonusCardBloc.state.gender,
                  onChanged: (value) => registerBonusCardBloc.add(
                    ChangeGenderEvent(GenderType.male),
                  ),
                ),
                SizedBox(width: 24.w),
                CustomRadioButton(
                  title: 'Женский',
                  value: GenderType.female,
                  groupValue: registerBonusCardBloc.state.gender,
                  onChanged: (value) => registerBonusCardBloc.add(
                    ChangeGenderEvent(GenderType.female),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
