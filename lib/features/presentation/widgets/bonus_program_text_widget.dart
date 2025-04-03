import 'package:flutter/material.dart';
import 'package:nevis/constants/ui_constants.dart';

class BonusProgramTextWidget extends StatelessWidget {
  const BonusProgramTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'При регистрации карты Вы принимаете условия ',
            style: UiConstants.textStyle11.copyWith(
              color: UiConstants.black2Color,
            ),
          ),
          TextSpan(
            text: 'Правил программы лояльности “ВАША КАРТА - CASHBACK”',
            style: UiConstants.textStyle11.copyWith(
              color: UiConstants.blueColor,
            ),
          ),
          TextSpan(
            text: ' и условия\n',
            style: UiConstants.textStyle11.copyWith(
              color: UiConstants.black2Color,
            ),
          ),
          TextSpan(
            text: 'политики конфиденциальности',
            style: UiConstants.textStyle11.copyWith(
              color: UiConstants.blueColor,
            ),
          ),
        ],
      ),
    );
  }
}
