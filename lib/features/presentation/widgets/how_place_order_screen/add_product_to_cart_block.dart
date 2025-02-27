import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';

import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/how_place_order_image.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/how_place_order_template.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/pink_container_widget.dart';

class AddProductToCartBlock extends StatelessWidget {
  const AddProductToCartBlock({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle descriptionStyle =
        UiConstants.textStyle2.copyWith(color: UiConstants.darkBlueColor);
    TextStyle boldStyle = UiConstants.textStyle3.copyWith(
        color: UiConstants.darkBlueColor, fontWeight: FontWeight.w800);
    return HowPlaceOrderTemplate(
      number: 2,
      title: 'Добавьте товар в корзину и оформите заказ',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: descriptionStyle,
              children: [
                TextSpan(
                    text:
                        'На странице товара Вы можете ознакомиться с характеристиками, наличием в аптеках, аналогами и другой полезной информацией о товаре. Для заказа необходимо выбрать количество упаковок и добавить их в корзину, нажав кнопку '),
                TextSpan(text: '«В корзину».', style: boldStyle),
                TextSpan(text: ' Выбранное количество будет добавлено '),
                TextSpan(text: 'в Корзину.', style: boldStyle),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          HowPlaceOrderImage(
              imagePath: Paths.howPlaceOrder3IconPath, height: 568.h),
          SizedBox(height: 16.h),
          RichText(
            text: TextSpan(
              style: descriptionStyle,
              children: [
                TextSpan(
                    text:
                        'Вы можете продолжать добавлять товары, а для оформления заказа нажмите кнопку "Корзина". Вам откроется список выбранных товаров, проверьте его, затем выберите аптеку для самовывоза или укажите адрес доставки, заполните данные о себе и нажмите кнопку '),
                TextSpan(text: '«Оформить заказ».', style: boldStyle),
                TextSpan(text: ' Стоимость заказа не ограничена.'),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          HowPlaceOrderImage(
              imagePath: Paths.howPlaceOrder4IconPath, height: 568.h),
          SizedBox(height: 16.h),
          Text(
              'После оформления заказа на указанную электронную почту придет письмо о получении Вашего заказа.\n\nОбработка заказа фармацевтическим работником осуществляется в течение 30 минут с момента получения.\n\nДождитесь звонка фармацевтического работника для фармацевтического консультирования и подтверждения заказа.',
              style: descriptionStyle),
          SizedBox(height: 16.h),
          PinkContainerWidget(
            children: [
              RichText(
                text: TextSpan(
                  style: descriptionStyle.copyWith(
                    color: UiConstants.darkBlue2Color.withOpacity(.8),
                  ),
                  children: [
                    TextSpan(
                        text:
                            'Заказы обрабатываются ежедневно с 09:00 до 21:00, при оформлении заказа после 21:00 менеджер свяжется с Вами после 09:00 следующего дня.\n\n'),
                    TextSpan(
                      text:
                          'Без согласования со специалистом колл-центра заказы не являются подтвержденными!',
                      style: descriptionStyle.copyWith(
                          color: UiConstants.pink2Color),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
