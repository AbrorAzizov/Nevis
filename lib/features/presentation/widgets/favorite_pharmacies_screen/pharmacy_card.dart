import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/pharmacy_entity.dart';
import 'package:nevis/features/presentation/bloc/order_pickup_screen/order_pickup_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_status_widget.dart';
import 'package:nevis/features/presentation/widgets/favorite_button.dart';

class PharmacyCard extends StatelessWidget {
  final PharmacyMapType mapType;
  final PharmacyEntity pharmacy;
  final void Function() onTap;
  const PharmacyCard(
      {super.key,
      required this.pharmacy,
      this.mapType = PharmacyMapType.defaultMap,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: getMarginOrPadding(top: 24, bottom: 24, left: 16, right: 16),
        decoration: BoxDecoration(
          border: mapType == PharmacyMapType.orderPickupMap
              ? Border.all(
                  color: context
                              .read<OrderPickupScreenBloc>()
                              .state
                              .selectedPharmacy ==
                          pharmacy
                      ? UiConstants.blueColor
                      : Colors.transparent)
              : null,
          color: UiConstants.whiteColor,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          pharmacy.address ?? 'Адрес',
                          style: UiConstants.textStyle19
                              .copyWith(color: UiConstants.black3Color),
                        ),
                      ),
                      FavoriteButton(
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Text(pharmacy.alias ?? 'аа', style: UiConstants.textStyle15),
                  // SizedBox(height: 4.h),
                  Text(pharmacy.phone ?? 'Телефон',
                      style: UiConstants.textStyle15),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: mapType == PharmacyMapType.orderPickupMap
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text('${pharmacy.schedule}',
                            style: UiConstants.textStyle15),
                      ),
                      if (mapType == PharmacyMapType.orderPickupMap)
                        CartStatusLabel(
                          pharmacy: pharmacy,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
