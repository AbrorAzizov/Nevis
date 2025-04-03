import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/formatters/custom_phone_input_formatter.dart';
import 'package:nevis/features/presentation/bloc/code_screen/code_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/register_bonus_card_screen/register_bonus_cardscreen_bloc.dart';
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
    final registerBonusCardBloc =
        widget.screenContext.read<RegisterBonusCardScreenBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            BlocProvider(
              create: (context) => CodeScreenBloc(
                  context: context.read<HomeScreenBloc>().context,
                  requestCodeUC: sl(),
                  phone: registerBonusCardBloc.phoneController.text,
                  code: registerBonusCardBloc.state.confirmPhoneCode,
                  loginUC: sl()),
              child: BlocConsumer<CodeScreenBloc, CodeScreenState>(
                listener: (context, state) async
                    // => switch (state) {
                    //   SuccessPasteState _ => await personalDataBloc.updateProfile(
                    //       confirmedCode: state.correctCode),
                    //   _ => {},
                    // },
                    =>
                    (),
                builder: (context, state) {
                  return AppTextFieldWidget(
                    textStyle: UiConstants.textStyle11,
                    fillColor: UiConstants.whiteColor,
                    title: 'Телефон',
                    hintText: '+7 (900) 000-00-00',
                    controller: registerBonusCardBloc.phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CustomPhoneInputFormatter()
                    ],
                    isActionTitleActive: registerBonusCardBloc
                                .state.installedPhone !=
                            registerBonusCardBloc.phoneController.text &&
                        registerBonusCardBloc.phoneController.text.length == 19,
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
                    onChangedField: (_) => setState(() {}),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
