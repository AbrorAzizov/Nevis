import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/about_us_block_template.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/pink_container_widget.dart';
import 'package:nevis/features/presentation/widgets/info_about_order_screen/text_with_paragraph_dot_widget.dart';

class CourierDeliveryTermsBlock extends StatelessWidget {
  const CourierDeliveryTermsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutUsBlockTemplate(
      title: 'Условия курьерской доставки',
      children: [
        TextWithParagraphDotWidget(
            regularPart:
                'Осуществляется в пределах г. Минск, а также в аг. Сеница, аг. Колодищи, пос. Колодищи-2, аг. Ждановичи, аг. Лесной, д. Дроздово, д. Колядичи, д. Тарасово, д. Боровляны, д. Лесковка, пос. Опытный, д. Раубичи, д. Боровая, д. Валерьяново, д. Копище, д. Зацень, д. Цнянка, д. Чижовка, д. Большое Стиклево, д. Большой Тростенец, аг. Щомыслица, аг. Прилуки, д. Богатырево, аг. Озерцо, пос. Юбилейный, д. Урожайная, д. Прилукская слобода'),
        SizedBox(height: 8.h),
        TextWithParagraphDotWidget(
            regularPart:
                'Осуществляется при наличии на протяжении подъездных путей дорожного покрытия. Если при транспортировке заказа покупателю к его адресу доставки дорожное покрытие отсутствовало либо было повреждено, то новое место доставки необходимо согласовать со специалистом колл-центра дополнительно. В случае их отстутствия покупателю необходимо спуститься за заказом самостоятельно.'),
        SizedBox(height: 8.h),
        TextWithParagraphDotWidget(
            boldPart:
                'При доставке заказа к зданию, имеющему закрытый въезд во двор',
            regularPart:
                ' (ворота, шлагбаум), покупателю необходимо организовать допуск автомобиля к зданию. При невозможности пропуска автомобиля покупателю необходимо подойти за заказом к курьеру самостоятельно.'),
        SizedBox(height: 8.h),
        TextWithParagraphDotWidget(
            boldPart:
                'При доставке заказа к зданию, не имеющему рядом бесплатных парковочных мест,',
            regularPart:
                ' покупателю необходимо подойти за заказом к курьеру самостоятельно в строго оговоренное с курьером время доставки.'),
        SizedBox(height: 8.h),
        PinkContainerWidget(
          children: [
            Text(
              'Внимание! Не осуществляется доставка:',
              style: UiConstants.textStyle3.copyWith(
                  color: UiConstants.pink2Color, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 8.h),
            TextWithParagraphDotWidget(
                regularPart: 'Рецептурных лекарственных препаратов'),
            SizedBox(height: 8.h),
            TextWithParagraphDotWidget(
                regularPart:
                    'Спиртосодержащих лекарственных препаратов с объемной долей спирта свыше 25%'),
          ],
        ),
      ],
    );
  }
}
