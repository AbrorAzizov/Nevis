import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/about_us_block_template.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_info_item.dart';

class GosfarmnadzorBlock extends StatelessWidget {
  const GosfarmnadzorBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutUsBlockTemplate(
      title: 'ГУ Госфармнадзор',
      children: [
        OrderInfoItem(
            imagePath: Paths.mailIconPath,
            title: 'Email',
            subtitle: 'info@gospharmnadzor.by'),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.pointIconPath,
            title: 'Адрес',
            subtitle:
                '220030, Республика Беларусь, г. Минск, ул.Мясникова, 32-2'),
      ],
    );
  }
}
