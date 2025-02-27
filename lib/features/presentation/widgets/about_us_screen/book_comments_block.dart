import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/about_us_block_template.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_info_item.dart';
// 

class BookCommentsBlock extends StatelessWidget {
  const BookCommentsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutUsBlockTemplate(
      title: 'Книга замечаний и предложений',
      textStyle: UiConstants.textStyle2,
      children: [
        OrderInfoItem(
            imagePath: Paths.phoneIconPath,
            title: 'Телефон',
            subtitle: '+375 (17) 393-36-19'),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.pointIconPath,
            title: 'Адрес',
            subtitle:
                'Аптека 34 ОДО "ДКМ-ФАРМ"г. Минск, тр-т. Долгиновский, д. 178, пом.178-102 - 178-107, 178-109, 178-112 - 178-114'),
        SizedBox(height: 8.h),
        SizedBox(height: 8.h),
        OrderInfoItem(
            imagePath: Paths.mailIconPath,
            title: 'Дополнительная информация',
            subtitle:
                'Лицо, уполномоченное рассматривать обращения покупателейо нарушении их прав, предусмотренных законодательствомо защите прав потребителей:\n\nСоленик Н.М. +375 (29) 635-27-65, pharm-i@inlek.by'),
      ],
    );
  }
}
