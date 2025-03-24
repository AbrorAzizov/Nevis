import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomPhoneInputFormatter extends MaskTextInputFormatter {
  CustomPhoneInputFormatter()
      : super(
          mask: '+# ### ### ## ##',
          filter: {'#': RegExp(r'[0-9]')},
        );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Проверяем, вставлен ли текст (разница длин больше одного символа)
    //if (newValue.text.length - oldValue.text.length > 1) {
    //  // Убираем символы +375 в начале
    //  if (newText.startsWith('+375')) {
    //    newText = newText.replaceFirst('+375', '+');
    //  }
    //}

    // Обеспечиваем, что длина текста не превышает максимальную длину маски
    if (newText.length > 19) {
      newText = newText.substring(0, 19);
    }

    // Форматируем текст с помощью MaskTextInputFormatter
    final updatedValue = super.formatEditUpdate(
        oldValue,
        TextEditingValue(
          text: newText,
          selection: newValue.selection,
        ));

    return updatedValue;
  }
}
