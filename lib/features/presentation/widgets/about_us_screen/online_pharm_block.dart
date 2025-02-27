import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/about_us_block_template.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_info_item.dart';

class OnlinePharmBlock extends StatelessWidget {
  const OnlinePharmBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutUsBlockTemplate(
      title: 'Интернет-аптека',
      icon: Paths.crossIconPath,
      children: [
        OrderInfoItem(
            imagePath: Paths.clockIconPath,
            title: 'Режим работы',
            subtitle: 'Пн–Вс: 09:00–21:00'),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.mailIconPath,
            title: 'Email',
            subtitle: 'apteka-online@inlek.by'),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.phoneIconPath,
            title: 'Колл-центр мобильные операторы',
            subtitle: '481'),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.phoneIconPath,
            title: 'Колл-центр',
            subtitle: '+375 (17) 388-76-78'),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.pointIconPath,
            title: 'Адрес',
            subtitle:
                'г. Минск, тр-т. Долгиновский, д. 178, пом.178-102 - 178-107, 178-109, 178-112 - 178-114'),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.document2IconPath,
            title: 'Дополнительная информация',
            subtitle:
                'Интернет-магазин apteka-online.by зарегистрирован в торговом реестре Республики Беларусь 26.05.2023 №558293'),
      ],
    );
  }
}
