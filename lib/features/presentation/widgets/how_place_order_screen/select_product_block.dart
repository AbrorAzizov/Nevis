import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/how_place_order_image.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/how_place_order_template.dart';

class SelectProductBlock extends StatelessWidget {
  const SelectProductBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return HowPlaceOrderTemplate(
      number: 1,
      title: 'Выберите товар',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выберите необходимые товары, воспользовавшись каталогом или строкой поиска. Не переживайте, если не помните название лекарственного препарата или медицинского изделия побуквенно! Наш умный поиск поможет найти именно то, что вам нужно:',
            style: UiConstants.textStyle2
                .copyWith(color: UiConstants.darkBlueColor),
          ),
          SizedBox(height: 32.h),
          Text(
            'Поиск по торговому названию',
            style: UiConstants.textStyle3.copyWith(
                color: UiConstants.darkBlueColor, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8.h),
          Text(
            'Просто введите название или его часть в поисковую строку. Поиск производится динамически по мере ввода запроса, и результаты отображаются сразу в выпадающем списке.',
            style: UiConstants.textStyle2
                .copyWith(color: UiConstants.darkBlueColor),
          ),
          SizedBox(height: 16.h),
          HowPlaceOrderImage(
              imagePath: Paths.howPlaceOrder1IconPath, height: 320.h),
          SizedBox(height: 32.h),
          Text(
            'Поиск по действующему веществу',
            style: UiConstants.textStyle3.copyWith(
                color: UiConstants.darkBlueColor, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8.h),
          Text(
            'Действующее вещество или действующие вещества обеспечивают препарату его основные свойства. Действующее вещество может указывать врач, выписывая рецепт или назначение. Наш поиск поможет Вам найти товары, содержащие указанное вещество или вещества, в разной ценовой категории.',
            style: UiConstants.textStyle2
                .copyWith(color: UiConstants.darkBlueColor),
          ),
          SizedBox(height: 16.h),
          HowPlaceOrderImage(
              imagePath: Paths.howPlaceOrder2IconPath, height: 320.h),
        ],
      ),
    );
  }
}
