import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class AddressCard extends StatelessWidget {
  final GeoObject geoObject;
  final Function() onUnselectPoint;

  const AddressCard(
      {super.key, required this.geoObject, required this.onUnselectPoint});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: getMarginOrPadding(all: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    geoObject.metaDataProperty?.geocoderMetaData?.address
                            ?.formatted ??
                        '',
                    style: UiConstants.textStyle19
                        .copyWith(color: UiConstants.black2Color),
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: onUnselectPoint,
                  child: SvgPicture.asset(
                    Paths.closeIconPath,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                        UiConstants.black3Color.withOpacity(.6),
                        BlendMode.srcIn),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            AppButtonWidget(
              text: 'Доставить сюда',
              onTap: () {
                Navigator.of(context).pop(geoObject);
              },
            )
          ],
        ));
  }
}
