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
            style: UiConstants.textStyle11.copyWith(
              color: UiConstants.black2Color,
             
            ),
          ),
          
          TextSpan(
            text: 'политики конфедициальности',
            style:
                UiConstants.textStyle11.copyWith(color: UiConstants.blueColor,),
          ),
           TextSpan(
            text: ' и',
            style: UiConstants.textStyle11.copyWith(
              color: UiConstants.black2Color,
            
            ),
          ),
           TextSpan(
            text: ' правила бонусной программы',
            style:
                UiConstants.textStyle11.copyWith(color: UiConstants.blueColor,),
          ),
         
        ],
      ),
    );
  }
}
