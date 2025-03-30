import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';

class PharmacyProductInfoCard extends StatelessWidget {
  final ProductPharmacyEntity pharmacy;
  final bool isSelected;
  final bool isForList;
  final int counter;
  final Function(int) onCounterChanged;
  const PharmacyProductInfoCard(
      {super.key,
      required this.pharmacy,
      this.isForList = false,
      this.isSelected = false,
      required this.counter,
      required this.onCounterChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getMarginOrPadding(top: 24, bottom: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: isSelected ? UiConstants.blueColor : Colors.transparent),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF144B63).withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: -4,
            offset: Offset(-1, -4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pharmacy.address!,
                  style: UiConstants.textStyle2
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'ул Двинская д.11',
                  style: UiConstants.textStyle10
                      .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  '7 812 490 92 70',
                  style: UiConstants.textStyle10
                      .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  pharmacy.schedule!,
                  style: UiConstants.textStyle10
                      .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${(pharmacy.price! * counter).toString()} ₽',
                            style: UiConstants.textStyle3.copyWith(
                                color: UiConstants.blueColor,
                                fontWeight: FontWeight.w800)),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'Годен до 01.08.2024',
                          style: UiConstants.textStyle10
                              .copyWith(color: UiConstants.redColor2),
                        )
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon:
                                Icon(Icons.remove, color: Colors.grey.shade700),
                            onPressed: () {
                              if (counter > 1) {
                                onCounterChanged(counter - 1);
                              }
                            },
                            splashRadius: 20,
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                          Text(
                            '$counter',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.grey.shade700),
                            onPressed: () {
                              onCounterChanged(counter + 1);
                            },
                            splashRadius: 20,
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                isForList
                    ? SizedBox.shrink()
                    : Padding(
                        padding: getMarginOrPadding(top: 16),
                        child: AppButtonWidget(
                          text: 'Заберу отсюда',
                          onTap: () {},
                          backgroundColor: UiConstants.blueColor,
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
