import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class QrCodeZoomWidget extends StatelessWidget {
  const QrCodeZoomWidget({super.key, required this.bytes});

  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: getMarginOrPadding(left: 16, right: 16, top: 16, bottom: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ColoredBox(
            color: UiConstants.whiteColor,
            child: Padding(
              padding: getMarginOrPadding(top: 64, bottom: 64),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Image.memory(
                      height: 70,
                      fit: BoxFit.fill,
                      bytes,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Text(
                      'Покажите этот код на кассе для получения скидки',
                      style: UiConstants.textStyle3.copyWith(
                        color: UiConstants.black3Color.withOpacity(.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
