import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/features/presentation/widgets/custom_radio_button.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_delivery/payment_method_plate_widget.dart';

class OrderDeliveryPaymentMethods extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final Function(PaymentMethod) changeMethod;

  const OrderDeliveryPaymentMethods(
      {super.key, required this.paymentMethod, required this.changeMethod});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomRadioButton(
              title: 'СБП',
              value: PaymentMethod.sbp,
              groupValue: paymentMethod,
              onChanged: (method) => changeMethod(method),
            ),
            SizedBox(width: 16.w),
            PaymentMethodPlateWidget(iconPath: Paths.sbpPlatePath),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            CustomRadioButton(
              title: 'Картой онлайн',
              value: PaymentMethod.card,
              groupValue: paymentMethod,
              onChanged: (method) => changeMethod(method),
            ),
            SizedBox(width: 16.w),
            PaymentMethodPlateWidget(iconPath: Paths.mirIconPath),
            SizedBox(width: 4.w),
            PaymentMethodPlateWidget(iconPath: Paths.visaIconPath),
            SizedBox(width: 4.w),
            PaymentMethodPlateWidget(iconPath: Paths.mastercardIconPath),
          ],
        ),
      ],
    );
  }
}
