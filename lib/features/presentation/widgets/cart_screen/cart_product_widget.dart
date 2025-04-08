import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/as_a_gift_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/product_price.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/special_offer_badge_widget.dart';
import 'package:nevis/features/presentation/widgets/delete_button_widget.dart';
import 'package:nevis/features/presentation/widgets/favorite_button.dart';
import 'package:nevis/features/presentation/widgets/sale_offer_widget.dart';

class CartProductWidget extends StatelessWidget {
  final ProductEntity product;

  const CartProductWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartScreenBloc>();
    final counters = bloc.state.counters;
    final productId = product.productId!;
    final count = counters[productId] ?? 1;

    return GestureDetector(
      onTap: () => {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: UiConstants.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF144B63).withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: -4,
              offset: Offset(-1, 4),
            ),
          ],
        ),
        child: Padding(
          padding: getMarginOrPadding(all: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: product.specialOffer != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                children: [
                  if (product.specialOffer != null)
                    TypeOfferWidget(specialOffer: product.specialOffer),
                  Row(
                    children: [
                      FavoriteButton(onPressed: () {}),
                      SizedBox(
                        width: 12.w,
                      ),
                      DeleteButton(onPressed: () {}),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  CachedNetworkImage(
                    height: 96.w,
                    width: 96.w,
                    imageUrl:
                        'https://upload.wikimedia.org/wikipedia/commons/7/7b/Корвалол-Фармак.jpg',
                    fit: BoxFit.contain,
                    cacheManager: CustomCacheManager(),
                    errorWidget: (context, url, error) => SvgPicture.asset(
                      Paths.drugTemplateIconPath,
                      height: double.infinity,
                    ),
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        color: UiConstants.blueColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name!.orDash(),
                            style: UiConstants.textStyle19
                                .copyWith(color: UiConstants.black3Color),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            product.brand ?? 'Производитель',
                            style: UiConstants.textStyle12.copyWith(
                                height: 1,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                color: UiConstants.black3Color.withOpacity(.6)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: ProductPrice(fromCart: true, product: product),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.grey.shade700),
                          onPressed: () {
                            if (count > 1) {
                              bloc.add(UpdateProductCountEvent(
                                productId: productId,
                                count: count - 1,
                              ));
                            }
                          },
                          splashRadius: 20,
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                        Text(
                          '$count',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.grey.shade700),
                          onPressed: () {
                            bloc.add(UpdateProductCountEvent(
                              productId: productId,
                              count: count + 1,
                            ));
                          },
                          splashRadius: 20,
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: getMarginOrPadding(top: 8),
                child: product.specialOffer != null
                    ? (count >= product.specialOffer!.count
                        ? AsGifetWidget(
                            product: product,
                            count: counters[product.productId] ?? 1,
                          )
                        : SpecialOfferBadgeWidget(
                            typeOfSpecialOffer: product.specialOffer!,
                          ))
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
