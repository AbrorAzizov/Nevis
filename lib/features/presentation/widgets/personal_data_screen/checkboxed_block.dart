import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
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
        AppTextFieldWidget(
            textStyle: UiConstants.textStyle11,
            fillColor: UiConstants.whiteColor,
            title: 'Email',
            hintText: 'Не указано',
            controller: personalDataBloc.emailController),
        SizedBox(
          height: 16.h,
        ),
        CustomCheckbox(
          title: Text(
            'Хочу получать рекламные рассылки по email, смс и пуш-уведомления',
            style: UiConstants.textStyle11.copyWith(
              color: UiConstants.darkBlue2Color.withOpacity(.8),
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
          //isEnabled: !personalDataBloc.state.isCheckedPolicyCheckbox,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      'Хочу получать сервисные пуш-уведомления (о работе приложения)',
                  style: UiConstants.textStyle11.copyWith(
                    color: UiConstants.black3Color.withOpacity(.8),
                  ),
                ),
              ],
            ),
          ),
          spacing: 16,
          isChecked:
              personalDataBloc.state.isCheckedNotifictaionAboutApplication,
          onChanged: (isChecked) => personalDataBloc.add(
            ChangePolicyCheckboxEvent(isChecked ?? false),
          ),
        )
      ],
    );
  }
}
