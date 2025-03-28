import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/catalog/products/product_screen.dart';
import 'package:nevis/features/presentation/pages/catalog/products/value_buy_product_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/product_price.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';
import 'package:nevis/features/presentation/widgets/favorite_pharmacies_screen/favorite_button.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity product;
  final bool isSelected;
  final bool showCheckbox;

  const ProductWidget(
      {super.key,
      required this.product,
      required this.isSelected,
      required this.showCheckbox});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        Routes.createRoute(
          const ProductScreen(),
          settings: RouteSettings(
            name: Routes.productScreen,
            arguments: product.productId,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFF144B63).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: -4,
            offset: Offset(-1, 4),
          ),
        ]),
        width: 180.w,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: UiConstants.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 120.h,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://upload.wikimedia.org/wikipedia/commons/7/7b/Корвалол-Фармак.jpg',
                        fit: BoxFit.fitWidth,
                        cacheManager: CustomCacheManager(),
                        errorWidget: (context, url, error) => SvgPicture.asset(
                            Paths.drugTemplateIconPath,
                            height: double.infinity),
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                              color: UiConstants.blueColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: getMarginOrPadding(top: 8, right: 8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FavoriteButton(
                        onPressed: () {},
                      ),
                    ),
                  ),
                  if (showCheckbox)
                    Padding(
                      padding: getMarginOrPadding(top: 8, left: 8),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: CustomCheckbox(
                              isChecked: isSelected,
                              onChanged: (_) {
                                context.read<FavoriteProductsScreenBloc>().add(
                                    ToggleProductSelection(product.productId!));
                              })),
                    ),
                ],
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 86.w,
                      height: 16.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        gradient: LinearGradient(
                          colors: [Color(0xFF85C6FF), Color(0xFFBF80FF)],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '10% КЕШБЕК',
                          style: UiConstants.textStyle6.copyWith(
                              fontWeight: FontWeight.w900,
                              color: UiConstants.whiteColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Container(
                          width: 52.w,
                          height: 16.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: UiConstants.greenColor),
                          child: Center(
                            child: Text(
                              'АКЦИЯ',
                              style: UiConstants.textStyle6.copyWith(
                                color: UiConstants.whiteColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Container(
                          width: 32.w,
                          height: 16.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: UiConstants.blueColor.withOpacity(.6)),
                          child: Center(
                            child: Text(
                              '1+1',
                              style: UiConstants.textStyle6.copyWith(
                                color: UiConstants.whiteColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SvgPicture.asset(Paths.recipe),
                        SizedBox(width: 4.w),
                        Text('Только по рецепту')
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      product.name ?? '',
                      style: UiConstants.textStyle8
                          .copyWith(color: UiConstants.darkBlueColor),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (product.valueBuy != null)
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            Routes.createRoute(
                              const ValueBuyProductScreen(),
                              settings: RouteSettings(
                                name: Routes.valueBuyProductScreen,
                                arguments: {'product': product},
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/value_buy.png'),
                                  fit: BoxFit.fill)),
                          width: 140.w,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, top: 6, bottom: 6, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Купить выгодно\n',
                                      style: UiConstants.textStyle15.copyWith(
                                          color: UiConstants.purpleColor)),
                                  TextSpan(
                                      text: 'от ${product.valueBuy} ₽',
                                      style: UiConstants.textStyle15.copyWith(
                                          color: UiConstants.purpleColor,
                                          fontWeight: FontWeight.w500)),
                                ])),
                                RotatedBox(
                                    quarterTurns: 1,
                                    child: SvgPicture.asset(
                                        Paths.dropdownArrowIconPath))
                              ],
                            ),
                          ),
                        ),
                      ),
                    product.valueBuy == null
                        ? SizedBox(height: 41.h)
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 40.h,
                      child: ProductPrice(product: product),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    AppButtonWidget(
                      isFilled: false,
                      showBorder: true,
                      isActive: true,
                      text: 'В корзину',
                      textColor: UiConstants.blueColor,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
