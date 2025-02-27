import 'package:flutter/services.dart';

class CvvInputFormatter extends TextInputFormatter {
  final int maxLength;

  CvvInputFormatter(
      {this.maxLength =
          3}); // По умолчанию 3 цифры, можно задать 4 для карт типа AmEx

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    if (nextValue.text.length > maxLength) {
      return previousValue;
    }
    return nextValue;
  }
}
