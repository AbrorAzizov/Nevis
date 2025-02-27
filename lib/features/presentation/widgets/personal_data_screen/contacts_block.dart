import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/bottom_sheet_manager.dart';
import 'package:nevis/core/formatters/custom_phone_input_formatter.dart';
import 'package:nevis/features/presentation/bloc/code_screen/code_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/locator_service.dart';


class ContactsBlock extends StatefulWidget {
  const ContactsBlock({super.key, required this.screenContext});

  final BuildContext screenContext;

  @override
  State<ContactsBlock> createState() => _ContactsBlockState();
}

class _ContactsBlockState extends State<ContactsBlock> {
  @override
  Widget build(BuildContext context) {
    final personalDataBloc =
        widget.screenContext.read<PersonalDataScreenBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Контакты',
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
              BlocProvider(
                create: (context) => CodeScreenBloc(
                    context: context.read<HomeScreenBloc>().context,
                    requestCodeUC: sl(),
                    phone: personalDataBloc.phoneController.text,
                    code: personalDataBloc.state.confirmPhoneCode),
                child: BlocConsumer<CodeScreenBloc, CodeScreenState>(
                  listener: (context, state) async => switch (state) {
                    SuccessPasteState _ => await personalDataBloc.updateProfile(
                        confirmedCode: state.correctCode),
                    _ => {},
                  },
                  builder: (context, state) {
                    return AppTextFieldWidget(
                      title: 'Телефон',
                      hintText: '+375 (00) 000-00-00',
                      controller: personalDataBloc.phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CustomPhoneInputFormatter()
                      ],
                      actionTitle: 'Изменить номер',
                      isActionTitleActive: personalDataBloc
                                  .state.installedPhone !=
                              personalDataBloc.phoneController.text &&
                          personalDataBloc.phoneController.text.length == 19,
                      onTapActionTitle: () async {
                        await context.read<CodeScreenBloc>().reset(
                            phone: personalDataBloc.phoneController.text);
                        context.read<CodeScreenBloc>().startTimer(
                          phone: personalDataBloc.phoneController.text,
                          widget.screenContext,
                          requestCodeFun: () async {
                            return await personalDataBloc.updateProfile(
                                requestedCode: true);
                          },
                        );
                        BottomSheetManager.showConfirmationCodeSheet(
                            context.read<HomeScreenBloc>().context,
                            context,
                            personalDataBloc);
                      },
                      onChangedField: (_) => setState(() {}),
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'При изменении номера телефона на новый номер будет отправлен код подтверждения',
                style: UiConstants.textStyle8.copyWith(
                  color: UiConstants.darkBlue2Color.withOpacity(.6),
                ),
              ),
              SizedBox(height: 16.h),
              AppTextFieldWidget(
                  title: 'Email',
                  hintText: 'Введите Email',
                  controller: personalDataBloc.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: Utils.emailValidate),
            ],
          ),
        ),
      ],
    );
  }
}
