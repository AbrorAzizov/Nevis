import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getMarginOrPadding(bottom: 94),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'В корзине пока ничего нет',
            style: UiConstants.textStyle9
                .copyWith(color: UiConstants.darkBlueColor),
          ),
          SizedBox(height: 8.h),
          Text(
            'Наполните ее товарами из каталога',
            style: UiConstants.textStyle3.copyWith(
              color: UiConstants.darkBlue2Color.withOpacity(.6),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Paths.emptyCartIconPath,
                    width: MediaQuery.of(context).size.width),
                Spacer(),
                AppButtonWidget(
                  isActive: true,
                  text: 'За покупками',
                  onTap: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
