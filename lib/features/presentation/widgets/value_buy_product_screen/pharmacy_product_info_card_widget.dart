import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';

class PharmacyProductInfoCard extends StatelessWidget {
  final ProductPharmacyEntity pharmacy;
  final bool isSelected;
  final bool isForList;
  final Function(int pharmacyId) onValueBuyPickUpRequested;
  final Function(int pharmacyId, int value) onValueBuyPickUpChangedCount;
  final Map<int, int> onValueBuyPickUpCounters;

  const PharmacyProductInfoCard({
    super.key,
    required this.pharmacy,
    this.isForList = false,
    this.isSelected = false,
    required this.onValueBuyPickUpChangedCount,
    required this.onValueBuyPickUpRequested,
    required this.onValueBuyPickUpCounters,
  });

  @override
  Widget build(BuildContext context) {
    int count = onValueBuyPickUpCounters[pharmacy.pharmacyId!]!;

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
                  pharmacy.address.orDash(),
                  style: UiConstants.textStyle2
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.h),
                Text(
                  extractStreetAndHouse(pharmacy.address ?? ''),
                  style: UiConstants.textStyle10
                      .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
                ),
                SizedBox(height: 8.h),
                Text(
                  pharmacy.phone.orDash(),
                  style: UiConstants.textStyle10
                      .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
                ),
                SizedBox(height: 8.h),
                Text(
                  pharmacy.schedule.orDash(),
                  style: UiConstants.textStyle10
                      .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${(pharmacy.price ?? 0 * count).toString()} ₽',
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
                      height: 32,
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
                              if (count > 1) {
                                onValueBuyPickUpChangedCount(
                                    pharmacy.pharmacyId!, count - 1);
                              }
                            },
                            splashRadius: 20,
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                          Text(
                            '$count',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.grey.shade700),
                            onPressed: () {
                              onValueBuyPickUpChangedCount(
                                  pharmacy.pharmacyId!, count + 1);
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
                          onTap: () =>
                              onValueBuyPickUpRequested(pharmacy.pharmacyId!),
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

  String extractStreetAndHouse(String address) {
    final regex = RegExp(
        r'((ул\.?|улица|пр\.?|проспект|пер\.?|переулок|шоссе|ш\.?|дорога|наб\.?|набережная|бульвар|бул\.?|площадь|пл\.?)\s?.+?,?\s?(дом\s?№?\s?\d+\w?|\d+\w?))',
        caseSensitive: false);
    final match = regex.firstMatch(address);
    return match?.group(0) ?? '';
  }
}
