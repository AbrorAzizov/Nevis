import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/loyalty_card_entity.dart';

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({super.key, required this.loyaltyCardQREntity});

  final LoyaltyCardQREntity loyaltyCardQREntity;

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(loyaltyCardQREntity.qrCode);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF144B63).withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: -4,
            offset: Offset(-1, -4),
          ),
        ],
        image: DecorationImage(
            image: AssetImage(Paths.qrCodeBackgorundIconPath),
            fit: BoxFit.fill),
      ),
      child: Padding(
        padding: getMarginOrPadding(all: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Color(0xFFBF80FF),
                      Color(0xFF85C6FF),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Text(
                    'ВАША КАРТА\nCASHBACK',
                    style: UiConstants.textStyle5.copyWith(
                        height: 1,
                        color: UiConstants.whiteColor,
                        letterSpacing: 0),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200.r),
                      gradient: LinearGradient(
                          colors: [Color(0xFFBF80FF), Color(0xFF85C6FF)])),
                  child: Container(
                    padding: getMarginOrPadding(left: 8, right: 16),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            width: 24, height: 24, Paths.bonusIcon2Path),
                        SizedBox(width: 8.w),
                        Padding(
                          padding: getMarginOrPadding(top: 4, bottom: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Бонусы',
                                style: UiConstants.textStyle15.copyWith(
                                  color: UiConstants.whiteColor,
                                ),
                              ),
                              Text(
                                loyaltyCardQREntity.bonusPoints.toString(),
                                style: UiConstants.textStyle19.copyWith(
                                  color: UiConstants.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(width: 4, color: UiConstants.purpleColor),
              ),
              child:
                  Image.memory(width: double.infinity, fit: BoxFit.fill, bytes),
            ),
          ],
        ),
      ),
    );
  }
}
