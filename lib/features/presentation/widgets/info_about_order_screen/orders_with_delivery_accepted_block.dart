import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/about_us_block_template.dart';
import 'package:nevis/features/presentation/widgets/info_about_order_screen/how_place_order_plate_widget.dart';
import 'package:nevis/features/presentation/widgets/info_about_order_screen/text_with_paragraph_dot_widget.dart';

class OrdersWithDeliveryAcceptedBlock extends StatelessWidget {
  const OrdersWithDeliveryAcceptedBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutUsBlockTemplate(
      title: 'Заказы с доставкой принимаются:',
      children: [
        TextWithParagraphDotWidget(
            boldPart: 'Круглосуточно ежедневно',
            regularPart: ' через приложение'),
        SizedBox(height: 8.h),
        TextWithParagraphDotWidget(
            boldPart: 'По режиму работы колл-центра',
            regularPart:
                ' по многоканальному номеру через фармацевтического работника колл-центра'),
        SizedBox(height: 8.h),
        TextWithParagraphDotWidget(
          child: Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'С 08.00 до 22.00 ежедневно',
                    style: UiConstants.textStyle3.copyWith(
                        color: UiConstants.darkBlueColor,
                        fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text:
                        ' через фармацевтического работника по номеру телефона аптеки ',
                    style: UiConstants.textStyle2
                        .copyWith(color: UiConstants.darkBlueColor),
                  ),
                  TextSpan(
                    text: '+375 (17) 393-36-19',
                    style: UiConstants.textStyle3.copyWith(
                        color: UiConstants.pink2Color,
                        fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text:
                        ' или при обращении в аптеку по адресу г. Минск, тр-т. Долгиновский, 178 (TЦ ALL).',
                    style: UiConstants.textStyle2
                        .copyWith(color: UiConstants.darkBlueColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        HowPlaceOrderPlateWidget()
      ],
    );
  }
}
