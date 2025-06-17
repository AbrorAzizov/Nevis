import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nevis/constants/ui_constants.dart';

class DateBirthdayWidget extends StatelessWidget {
  const DateBirthdayWidget(
      {super.key, this.selectedDate, required this.onSelectedDate});

  final DateTime? selectedDate;
  final Function(DateTime date) onSelectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final now = DateTime.now();
        DateTime? initialDate = selectedDate;

        initialDate ??= DateTime(now.year - 18, now.month, now.day);
        final picked = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(1900),
          lastDate: now,
          locale: const Locale('ru', 'RU'),
        );
        if (picked != null) {
          onSelectedDate(picked);
        }
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Дата рождения',
              style: UiConstants.textStyle11,
            ),
            Row(
              children: [
                Text(
                  selectedDate != null
                      ? DateFormat('dd.MM.yyyy').format(selectedDate!)
                      : 'Не выбрано',
                  style: UiConstants.textStyle11.copyWith(
                    color: selectedDate != null
                        ? UiConstants.black3Color
                        : UiConstants.black2Color.withOpacity(.6),
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(Icons.chevron_right,
                    color: UiConstants.black2Color.withOpacity(.6)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
