import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';

class InternetNoInternetConnectionWidget extends StatelessWidget {
  const InternetNoInternetConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getMarginOrPadding(left: 20, right: 20, bottom: 94),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Нет соединения',
            style: UiConstants.textStyle1
                .copyWith(color: UiConstants.darkBlueColor),
          ),
          SizedBox(height: 8.h),
          Text(
            'Проверьте подключение к интернету или попробуйте позднее.',
            style: UiConstants.textStyle2
                .copyWith(color: UiConstants.darkBlueColor),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Paths.noInternetConnectionIconPath,
                    width: MediaQuery.of(context).size.width),
                Spacer(),
                AppButtonWidget(
                  isActive: true,
                  text: 'Обновить',
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
