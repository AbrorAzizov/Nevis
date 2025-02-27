import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/about_us_block_template.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/more_detail_plate.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_info_item.dart';

class LegalAddressBlock extends StatelessWidget {
  const LegalAddressBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutUsBlockTemplate(
      title: 'Юридический адрес',
      children: [
        OrderInfoItem(
            imagePath: Paths.mailIconPath,
            title: 'Email',
            subtitle: 'inlek@inlek.by'),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.phoneIconPath,
            title: 'Телефон приемной',
            subtitle: '+375 (44) 755-17-27'),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.pointIconPath,
            title: 'Адрес',
            subtitle: '220113 г. Минск,ул. Якуба Коласа, 73/3-6, 6 этаж'),
        SizedBox(height: 8.h),
        OrderInfoItem(
          imagePath: Paths.document2IconPath,
          title: 'Дополнительная информация',
          subtitleWidget: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      'Общество с дополнительной ответственностью «ДКМ-ФАРМ», УНП 190431476\n\n',
                  style: UiConstants.textStyle3
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
                TextSpan(
                  text:
                      'Зарегистрировано решением Мингорисполкома от 20.03.2003 №395 Лицензия Ф-265 от 22.05.2003',
                  style: UiConstants.textStyle8
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: getMarginOrPadding(top: 17, bottom: 17),
          child: Divider(
            color: UiConstants.white5Color,
          ),
        ),
        MoreDetailPlate(
            onTap: () {}, imagePath: Paths.licenseIconPath, title: 'Лицензии'),
        SizedBox(height: 8.h),
        MoreDetailPlate(
            onTap: () {},
            imagePath: Paths.offerIconPath,
            title: 'Публичная оферта'),
      ],
    );
  }
}
