import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/pharmacy_available_products_chip.dart';

import 'package:skeletonizer/skeletonizer.dart';

class CartPharmacyWidget extends StatelessWidget {
  const CartPharmacyWidget({
    super.key,
    required this.pharmacy,
    required this.pharmacyListScreenType,
    this.onButtonTap,
    this.screenContext,
  });

  final ProductPharmacyEntity pharmacy;
  final PharmacyListScreenType pharmacyListScreenType;
  final Function()? onButtonTap;
  final BuildContext? screenContext;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartScreenBloc, CartScreenState>(
      bloc: screenContext?.read<CartScreenBloc>(),
      buildWhen: (previous, current) => screenContext == null,
      builder: (context, state) {
        bool allProductsAvailable = true;
        //bool allProductsAvailable = state.selectedProductIds.every(
        //    (e) => pharmacy.availableProducts.map((e) => e.id).contains(e));
        return Container(
          padding: getMarginOrPadding(top: 16, bottom: 16, left: 20, right: 20),
          decoration: BoxDecoration(
            color: UiConstants.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (pharmacyListScreenType ==
                          PharmacyListScreenType.product &&
                      pharmacy.pharmacyDelivery == 'Доставка')
                    Skeleton.replace(
                      child: Container(
                        margin: getMarginOrPadding(right: 9),
                        height: 24.w,
                        width: 24.w,
                        padding: getMarginOrPadding(all: 4),
                        decoration: BoxDecoration(
                            color: UiConstants.purple3Color,
                            shape: BoxShape.circle),
                        child: SvgPicture.asset(Paths.carIconPath,
                            height: double.infinity, width: double.infinity),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      pharmacyListScreenType ==
                                  PharmacyListScreenType.product &&
                              pharmacy.pharmacyDelivery == 'Доставка'
                          ? 'Доставка'
                          : pharmacy.pharmacyName.orDash(),
                      style: UiConstants.textStyle3.copyWith(
                          color: UiConstants.darkBlueColor,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                pharmacy.address.orDash(),
                style: UiConstants.textStyle2
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
              if (pharmacyListScreenType == PharmacyListScreenType.cart)
                Padding(
                  padding: getMarginOrPadding(top: 16),
                  child: PharmacyAvailableProductsChip(
                      allProductsAvailable: allProductsAvailable),
                ),
              if (pharmacyListScreenType == PharmacyListScreenType.product)
                Padding(
                  padding: getMarginOrPadding(top: 8),
                  child: Text(
                    pharmacy.expirationDate.orDash(),
                    style: UiConstants.textStyle8.copyWith(
                      color: UiConstants.darkBlueColor.withOpacity(.6),
                    ),
                  ),
                ),
              if (pharmacyListScreenType == PharmacyListScreenType.product)
                Padding(
                  padding: getMarginOrPadding(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'В наличии ${pharmacy.stockCount} шт.',
                          style: UiConstants.textStyle2.copyWith(
                              color: UiConstants.darkBlueColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '1 шт.',
                            style: UiConstants.textStyle8.copyWith(
                              color: UiConstants.darkBlue2Color.withOpacity(.6),
                            ),
                          ),
                          Text(
                            Utils.formatPrice(pharmacy.price),
                            style: UiConstants.textStyle5
                                .copyWith(color: UiConstants.darkBlueColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (onButtonTap != null)
                Padding(
                  padding: getMarginOrPadding(top: 16),
                  child: AppButtonWidget(
                      isFilled: allProductsAvailable,
                      showBorder: !allProductsAvailable,
                      textColor:
                          allProductsAvailable ? null : UiConstants.purpleColor,
                      isActive: true,
                      text: allProductsAvailable ? 'Выбрать' : 'Подробнее',
                      onTap: onButtonTap),
                )
            ],
          ),
        );
      },
    );
  }
}
