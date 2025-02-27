import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/extensions.dart';

import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_characteristic_item.dart';

class ProductCharacteristicWidget extends StatelessWidget {
  final ProductEntity? product;

  const ProductCharacteristicWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductCharacteristicItem(
            title: 'Международное непатентованное название',
            subtitle: product!.mnn.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Порядок отпуска фактический',
            subtitle: product!.recipe.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Производитель', subtitle: product!.brand.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Страна производства', subtitle: product!.country.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Лекарственная форма', subtitle: product!.form.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Дозировка', subtitle: product!.dose.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'МНН англ/лат', subtitle: product!.mnnLat.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Штрих-код', subtitle: product!.code.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Форма выпуска', subtitle: product!.releaseForm.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Путь введения', subtitle: product!.productInsert.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Срок регистрации',
            subtitle: product!.productTimeRegister.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Регистрационное удостоверение',
            subtitle: product!.productRegister.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Дата регистрации',
            subtitle: product!.productDateRegister.orDash()),
        SizedBox(height: 8.h),
        ProductCharacteristicItem(
            title: 'Температура хранения',
            subtitle: product!.temperature.orDash()),
      ],
    );
  }
}
