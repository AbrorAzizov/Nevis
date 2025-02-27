import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/presentation/pages/catalog/pharmacies_screen.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_receiving_method_item.dart';

class ProductReceivingMethodsWidget extends StatelessWidget {
  final List<ProductPharmacyEntity> pharmacies;

  const ProductReceivingMethodsWidget({super.key, required this.pharmacies});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ProductReceivingMethodItem(
            title: 'В наличии',
            subtitle:
                'в ${pharmacies.length} ${Utils.getPharmacyLabel(pharmacies.length)}',
            onTap: () => Navigator.of(context).push(
              Routes.createRoute(
                const PharmaciesScreen(),
                settings: RouteSettings(
                    name: Routes.pharmaciesScreen, arguments: pharmacies),
              ),
            ),
            onTapArrowButton: () {},
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: ProductReceivingMethodItem(
              title: 'Самовывоз', subtitle: 'от 30 мин'),
        ),
      ],
    );
  }
}
