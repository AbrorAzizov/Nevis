import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/register_bonus_card_screen/register_bonus_cardscreen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';

class CheckboxesBlock extends StatefulWidget {
  const CheckboxesBlock({super.key, required this.screenContext});

  final BuildContext screenContext;

  @override
  State<CheckboxesBlock> createState() => _CheckboxesBlockState();
}

class _CheckboxesBlockState extends State<CheckboxesBlock> {
  @override
  Widget build(BuildContext context) {
    final registerBonusCardBloc =
        widget.screenContext.read<RegisterBonusCardScreenBloc>();
    return Column(
      children: [
        AppTextFieldWidget(
            textStyle: UiConstants.textStyle11,
            fillColor: UiConstants.whiteColor,
            title: 'Email',
            hintText: 'Не указано',
            controller: registerBonusCardBloc.emailController),
      ],
    );
  }
}
