import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';
import 'package:nevis/features/presentation/widgets/order_screen/order_delivery/bonuses_field.dart';

class OrderDeliveryBonuses extends StatelessWidget {
  final int bonuses;
  final bool isChecked;
  final ValueChanged<bool?> onCheckboxChanged;
  final ValueChanged<String> onBonusesChanged;
  const OrderDeliveryBonuses({
    super.key,
    required this.bonuses,
    required this.isChecked,
    required this.onCheckboxChanged,
    required this.onBonusesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: CustomCheckbox(
            title: 'Списать бонусы ($bonuses)',
            isChecked: isChecked,
            onChanged: onCheckboxChanged,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          flex: 2,
          child: BonusesField(
            isEnabled: isChecked,
            onChangedField: onBonusesChanged,
          ),
        ),
      ],
    );
  }
}
