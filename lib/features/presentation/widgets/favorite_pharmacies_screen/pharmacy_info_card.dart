import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/presentation/widgets/favorite_button.dart';

class PharmacyInfoCard extends StatelessWidget {
  final PharmacyEntity pharmacy;
  const PharmacyInfoCard({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(all: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              spacing: 12.h,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: UiConstants.lightGreyColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: getMarginOrPadding(all: 8),
                        child: SvgPicture.asset(
                          width: 16,
                          height: 16,
                          Paths.geoIconPath,
                          colorFilter: ColorFilter.mode(
                              UiConstants.black3Color.withOpacity(.4),
                              BlendMode.srcIn),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Аптека Невис\n',
                                style: UiConstants.textStyle10.copyWith(
                                    color: UiConstants.black3Color
                                        .withOpacity(.6))),
                            TextSpan(
                                text: pharmacy.address,
                                style: UiConstants.textStyle10
                                    .copyWith(color: UiConstants.black3Color)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: UiConstants.lightGreyColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: getMarginOrPadding(all: 8),
                        child: SvgPicture.asset(
                          Paths.clockIconPath,
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                              UiConstants.black3Color.withOpacity(.4),
                              BlendMode.srcIn),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Режим работы\n',
                            style: UiConstants.textStyle10.copyWith(
                                color:
                                    UiConstants.black3Color.withOpacity(.6))),
                        TextSpan(
                            text:
                                '${pharmacy.schedule}\n${pharmacy.textCloseTime}',
                            style: UiConstants.textStyle10
                                .copyWith(color: UiConstants.black3Color)),
                      ])),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: UiConstants.lightGreyColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: getMarginOrPadding(all: 8),
                        child: SvgPicture.asset(
                          Paths.phoneIconPath,
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                              UiConstants.black3Color, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Телефон\n',
                                style: UiConstants.textStyle10.copyWith(
                                    color: UiConstants.black3Color
                                        .withOpacity(.6))),
                            TextSpan(
                                text: '${pharmacy.phone}\n',
                                style: UiConstants.textStyle10
                                    .copyWith(color: UiConstants.black3Color)),
                            TextSpan(
                                text: 'Позвонить',
                                style: UiConstants.textStyle10
                                    .copyWith(color: UiConstants.blueColor)),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: 4.w),
          FavoriteButton(
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
