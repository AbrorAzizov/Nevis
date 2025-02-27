import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';

class CheckboxesBlock extends StatefulWidget {
  const CheckboxesBlock({super.key, required this.screenContext});

  final BuildContext screenContext;

  @override
  State<CheckboxesBlock> createState() => _CheckboxesBlockState();
}

class _CheckboxesBlockState extends State<CheckboxesBlock> {
  @override
  Widget build(BuildContext context) {
    final personalDataBloc =
        widget.screenContext.read<PersonalDataScreenBloc>();
    return Column(
      children: [
        CustomCheckbox(
          title: Text(
            'Хочу получать уведомления о статусе заказов и акциях',
            style: UiConstants.textStyle3.copyWith(
              color: UiConstants.darkBlue2Color.withOpacity(.6),
            ),
          ),
          spacing: 16,
          isChecked: personalDataBloc.state.isCheckedNotificationCheckbox,
          onChanged: (isChecked) => personalDataBloc.add(
            ChangeNotificationCheckboxEvent(isChecked ?? false),
          ),
        ),
        SizedBox(height: 16.h),
        CustomCheckbox(
          isEnabled: !personalDataBloc.state.isCheckedPolicyCheckbox,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Принимаю условия ',
                  style: UiConstants.textStyle3.copyWith(
                    color: UiConstants.darkBlue2Color.withOpacity(.6),
                  ),
                ),
                TextSpan(
                  text: 'Политики обработки персональных данных',
                  style: UiConstants.textStyle3
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
              ],
            ),
          ),
          spacing: 16,
          isChecked: personalDataBloc.state.isCheckedPolicyCheckbox,
          onChanged: (isChecked) => personalDataBloc.add(
            ChangePolicyCheckboxEvent(isChecked ?? false),
          ),
        )
      ],
    );
  }
}
