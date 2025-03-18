import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class CardPaymentRules extends StatelessWidget {
  const CardPaymentRules({super.key});

  @override
  Widget build(BuildContext context) {
    List<Image> paymentMethods = [
      Image.asset(Paths.mirIconPath),
      Image.asset(Paths.visaIconPath),
      Image.asset(Paths.mastercardIconPath),
      Image.asset(Paths.jcbIconPath),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Олпата заказа банковской картой',
          style: UiConstants.textStyle13,
        ),
        SizedBox(
          height: 24.h,
        ),
        Text(
          '''Для выбора оплаты товара с помощью банковской карты на странице Заказы,

в личном кабинете необходимо нажать кнопку Оплатить заказ банковской картой. Оплата происходит через ПАО СБЕРБАНК

с использованием банковских карт следующих платёжных систем:''',
          style: UiConstants.textStyle11,
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(paymentMethods.length, (int index) {
            return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: UiConstants.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x19144B63), // #144B63 с 10% прозрачности
                        offset: Offset(-1, 4), // Смещение
                        blurRadius: 50, // Размытие
                        spreadRadius: -4, // Распространение
                      ),
                    ]),
                child: Padding(
                  padding: getMarginOrPadding(all: 8),
                  child: paymentMethods[index],
                ));
          }),
        ),
        SizedBox(height: 24.h,),
        Text(
          '''Для оплаты (ввода реквизитов Вашей карты) Вы будете перенаправлены на платёжный шлюз ПАО СБЕРБАНК. Соединение

с платёжным шлюзом и передача информации осуществляется в защищённом режиме с использованием протокола шифрования SSL. В случае если Ваш банк поддерживает технологию безопасного проведения интернет-платежей Verified By Visa, MasterCard SecureCode, MIR Accept, J-Secure, для проведения платежа также может потребоваться ввод специального пароля

Настоящее приложение поддерживает
256-битное шифрование. Конфиденциальность сообщаемой персональной информации обеспечивается ПАО СБЕРБАНК. Введённая информация не будет предоставлена третьим лицам за исключением случаев, предусмотренных законодательством РФ. Проведение платежей по банковским картам осуществляется в строгом соответствии с требованиями платёжных систем МИР, Visa Int., MasterCard Europe Sprl, JCB.''',
          style: UiConstants.textStyle11,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16.h,)
      ],
    );
  }
}
