import 'package:flutter/material.dart';

import 'package:nevis/constants/ui_constants.dart';

class PolicyTextWidget extends StatelessWidget {
  const PolicyTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'При входе на ресурс Вы принимаете условия\n',
            style: UiConstants.textStyle3.copyWith(
              color: UiConstants.darkBlue2Color.withOpacity(.6),
            ),
          ),
          TextSpan(
            text: 'Политики обработки персональных данных',
            style:
                UiConstants.textStyle3.copyWith(color: UiConstants.purpleColor),
          ),
        ],
      ),
    );
  }
}
