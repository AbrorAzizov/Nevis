import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/change_count_product_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/info_border_plate.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/only_pickup_chip.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/out_stock_chip.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/product_price.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/product_stock_chip.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';
import 'package:nevis/features/presentation/widgets/product_chip_widget.dart';

import 'package:skeletonizer/skeletonizer.dart';

class CartProductWidget extends StatefulWidget {
  const CartProductWidget({
    super.key,
    required this.index,
    required this.product,
    required this.productsListScreenType,
    this.screenContext,
  });

  final int index;
  final ProductEntity product;
  final ProductsListScreenType productsListScreenType;
  final BuildContext? screenContext;

  @override
  State<CartProductWidget> createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<CartProductWidget> {
  bool inStock = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartScreenBloc, CartScreenState>(
      bloc: widget.screenContext?.read<CartScreenBloc>(),
      buildWhen: (previous, current) => widget.screenContext == null,
      builder: (context, state) {
        final bloc = (widget.screenContext ?? context).read<CartScreenBloc>();

        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF144B63).withOpacity(0.1),
                blurRadius: 50,
                spreadRadius: -4,
                offset: Offset(-1, -4),
              ),
            ],
          ),
          child: GestureDetector(
            child: DismissibleTile(
              onDismissed: (_) => bloc.add(
                DeleteProductEvent(widget.product.productId!),
              ),
              direction:
                  widget.productsListScreenType == ProductsListScreenType.cart
                      ? DismissibleTileDirection.rightToLeft
                      : DismissibleTileDirection.none,
              key: UniqueKey(),
              borderRadius: BorderRadius.all(
                Radius.circular(16.r),
              ),
              delayBeforeResize: const Duration(milliseconds: 500),
              rtlBackground: const ColoredBox(color: UiConstants.redColor),
              rtlOverlayIndent: 0,
              rtlDismissedColor: UiConstants.redColor,
              rtlOverlay: SvgPicture.asset(Paths.deleteIconPath,
                  height: 24.w, width: 24.w, color: UiConstants.whiteColor),
              rtlOverlayDismissed: SvgPicture.asset(Paths.deleteIconPath,
                  height: 24.w, width: 24.w, color: UiConstants.whiteColor),
              child: Container(
                padding: getMarginOrPadding(all: 16),
                decoration: BoxDecoration(
                  color: UiConstants.whiteColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (inStock &&
                            widget.productsListScreenType ==
                                ProductsListScreenType.cart)
                          CustomCheckbox(
                            isChecked: state.selectedProductIds
                                .contains(widget.product.productId),
                            onChanged: (isChecked) => bloc.add(
                              ToggleSelectionEvent(
                                  isChecked, widget.product.productId!),
                            ),
                          ),
                        SizedBox(width: 8.w),
                        Stack(
                          children: [
                            CachedNetworkImage(
                              height: 96.w,
                              width: 96.w,
                              imageUrl:
                                  'https://upload.wikimedia.org/wikipedia/commons/7/7b/Корвалол-Фармак.jpg',
                              // '${dotenv.env['PUBLIC_URL']!}${widget.product.image}',
                              fit: BoxFit.contain,
                              cacheManager: CustomCacheManager(),
                              errorWidget: (context, url, error) =>
                                  SvgPicture.asset(Paths.drugTemplateIconPath,
                                      height: double.infinity),
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                    color: UiConstants.pink2Color),
                              ),
                            ),
                            if (!inStock)
                              Container(
                                height: 104.w,
                                width: 104.w,
                                color: UiConstants.whiteColor.withOpacity(.6),
                              ),
                            Positioned(
                              top: 4.h,
                              left: 8.w,
                              right: 8.w,
                              child: Wrap(
                                spacing: 4.w,
                                runSpacing: 4.w,
                                children: widget.index % 3 == 2 && inStock
                                    ? [
                                        ProductChipWidget(
                                            productChipType:
                                                ProductChipType.seasonalOffer),
                                        ProductChipWidget(
                                            productChipType:
                                                ProductChipType.nova),
                                        ProductChipWidget(
                                            productChipType:
                                                ProductChipType.stock),
                                      ]
                                    : widget.index % 3 == 1 && inStock
                                        ? [
                                            ProductChipWidget(
                                                productChipType:
                                                    ProductChipType.hit)
                                          ]
                                        : [],
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(widget.product.name.orDash(),
                                      style: UiConstants.textStyle8.copyWith(
                                        color: inStock
                                            ? UiConstants.darkBlueColor
                                            : UiConstants.darkBlue2Color
                                                .withOpacity(.6),
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(widget.product.brand!),
                                    ],
                                  ),
                                ],
                              ),
                              if (!inStock)
                                Padding(
                                  padding: getMarginOrPadding(bottom: 4),
                                  child: OutStockChip(),
                                ),
                             
                                
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: widget
                                            .productsListScreenType ==
                                        ProductsListScreenType.order
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment
                                        .center, // TODO: если нет скидки, то CrossAxisAlignment.end
                                children: [
                                  if (inStock &&
                                      widget.productsListScreenType !=
                                          ProductsListScreenType.order)
                                    Padding(
                                      padding: getMarginOrPadding(
                                          top: 2, bottom: 2, left: 8),
                                      child: ChangeCountProductWidget(
                                        count: widget.product.count ?? 0,
                                        onCountChange: (bool isIncrement) {
                                          //setState(() => isIncrement
                                          //    ? productCount++
                                          //    : productCount--);
                                          bloc.add(
                                            ChangeProductCountEvent(
                                                widget.product.productId!,
                                                isIncrement),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ProductPrice(product: widget.product),
                        ),
                        if (widget.productsListScreenType ==
                            ProductsListScreenType.order)
                          Text(
                            '${widget.product.count} шт.',
                            style: UiConstants.textStyle8
                                .copyWith(color: UiConstants.black3Color),
                          ),
                      ],
                    ),
                    if (widget.index % 5 == 1 && state.promoCodes.isNotEmpty)
                      Padding(
                        padding: getMarginOrPadding(top: 8),
                        child: InfoBorderPlate(
                            imagePath: Paths.stockIconPath,
                            title:
                                'Этот товар уже со скидкой, промокод не действует'),
                      ),
                    if (widget.index % 3 == 2)
                      Padding(
                        padding: getMarginOrPadding(top: 8),
                        child: ProductStockChip(),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
