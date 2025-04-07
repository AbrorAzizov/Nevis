import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_payment_block_item.dart';

class DeliveryPaymentBlock extends StatefulWidget {
  const DeliveryPaymentBlock({
    super.key,
    required this.screenContext,
    required this.changedOnlineMethodTap,
  });

  final BuildContext screenContext;
  final Function() changedOnlineMethodTap;

  @override
  State<DeliveryPaymentBlock> createState() => _DeliveryPaymentBlockState();
}

class _DeliveryPaymentBlockState extends State<DeliveryPaymentBlock> {
  late CartScreenBloc cartBloc;
  late PaymentType paymentType;

  @override
  void initState() {
    cartBloc = widget.screenContext.read<CartScreenBloc>();
    paymentType = cartBloc.state.paymentType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '3. Способ оплаты',
          style:
              UiConstants.textStyle5.copyWith(color: UiConstants.darkBlueColor),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: DeliveryPaymentBlockItem(
                imagePath: Paths.courierIconPath,
                title: 'Курьеру',
                subtitle: 'Картой или наличными',
                isChecked: paymentType == PaymentType.inPerson,
                onTap: () {
                  // setState(() => paymentType = PaymentType.inPerson);
                  // cartBloc.add(
                  //   ChangePaymentTypeEvent(PaymentType.inPerson),
                  // );
                },
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: DeliveryPaymentBlockItem(
                  imagePath: Paths.cardIconPath,
                  title: 'Онлайн',
                  isChecked: paymentType == PaymentType.online,
                  onTap: () {
                    // setState(() => paymentType = PaymentType.online);
                    // cartBloc.add(
                    //   ChangePaymentTypeEvent(PaymentType.online),
                    // );
                  },
                  changedOnlineMethodTap: widget.changedOnlineMethodTap),
            ),
          ],
        )
      ],
    );
  }
}
