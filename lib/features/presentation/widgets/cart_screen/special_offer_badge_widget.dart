import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';

class SpecialOfferBadgeWidget extends StatelessWidget {
  final TypeOfSpecialOffer typeOfSpecialOffer;
  const SpecialOfferBadgeWidget({super.key, required this.typeOfSpecialOffer});

  @override
  Widget build(BuildContext context) {
    List<String> offerTexts = Utils.specialOfferText(typeOfSpecialOffer);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: UiConstants.blue2Color),
      child: Padding(
        padding: getMarginOrPadding(top: 6, left: 4, bottom: 6),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: UiConstants.whiteColor.withOpacity(.8),
              ),
              child: Padding(
                  padding: getMarginOrPadding(all: 4),
                  child: SvgPicture.asset(
                    Paths.giftconPath,
                  )),
            ),
            SizedBox(
              width: 8.w,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Акция ${offerTexts[0]}',
                  style: UiConstants.textStyle15
                      .copyWith(height: 1, color: UiConstants.blueColor)),
              TextSpan(
                  text: ' - ${offerTexts[1]}\n',
                  style: UiConstants.textStyle15.copyWith(
                      height: 1,
                      color: UiConstants.black3Color.withOpacity(.6))),
              TextSpan(
                  text: 'в подарок!',
                  style: UiConstants.textStyle15
                      .copyWith(height: 1, color: UiConstants.blueColor))
            ])),
          ],
        ),
      ),
    );
  }
}
