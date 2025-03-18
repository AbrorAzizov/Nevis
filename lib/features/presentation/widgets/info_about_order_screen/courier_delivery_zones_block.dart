import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/presentation/bloc/info_about_order_screen/info_about_order_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/about_us_block_template.dart';
import 'package:nevis/features/presentation/widgets/info_about_order_screen/courier_delivery_zone_item.dart';
import 'package:nevis/features/presentation/widgets/map/pharmacy_map_widget.dart';

class CourierDeliveryZonesBlock extends StatelessWidget {
  const CourierDeliveryZonesBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoAboutOrderScreenBloc, InfoAboutOrderScreenState>(
      builder: (context, state) {
        return AboutUsBlockTemplate(
          title: 'Зоны курьерской доставки',
          children: [
            PharmacyMapWidget(
              points: [],
            ),
            SizedBox(height: 16.h),
            CourierDeliveryZoneItem(
                title: 'Зелёная зона',
                subtitle:
                    'Бесплатно — для заказов от 40 руб.\nПлатно — для заказов до 40 руб.',
                deliveryZoneType: DeliveryZoneType.green),
            SizedBox(height: 16.h),
            CourierDeliveryZoneItem(
                title: 'Желтая зона',
                subtitle: 'Платная доставка',
                deliveryZoneType: DeliveryZoneType.yellow),
          ],
        );
      },
    );
  }
}
