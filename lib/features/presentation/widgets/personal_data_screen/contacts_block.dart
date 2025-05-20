import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/formatters/custom_phone_input_formatter.dart';
import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';

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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(children: [
        AppTextFieldWidget(
          readOnly: true,
          textStyle: UiConstants.textStyle11,
          fillColor: UiConstants.whiteColor,
          title: 'Телефон',
          hintText: '+7 (900) 000-00-00',
          controller: personalDataBloc.phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CustomPhoneInputFormatter()
          ],
          isActionTitleActive: personalDataBloc.state.installedPhone !=
                  personalDataBloc.phoneController.text &&
              personalDataBloc.phoneController.text.length == 19,
          onTapActionTitle: () async {},
        )
      ])
    ]);
  }
}
