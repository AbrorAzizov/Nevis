import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_pickup_cart_screen/order_pickup_cart_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/as_a_gift_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/product_price.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/special_offer_badge_widget.dart';
import 'package:nevis/features/presentation/widgets/counter_widget.dart';
import 'package:nevis/features/presentation/widgets/delete_button_widget.dart';
import 'package:nevis/features/presentation/widgets/favorite_button.dart';
import 'package:nevis/features/presentation/widgets/sale_offer_widget.dart';

class CartProductWidget extends StatelessWidget {
  final ProductEntity product;
  final CartType cartType;
  final PharmacyProductsAvailabilityType availabilityType;
  final void Function()? additionalEvent;

  const CartProductWidget({
    super.key,
    this.availabilityType = PharmacyProductsAvailabilityType.available,
    this.cartType = CartType.defaultCart,
    required this.product,
    this.additionalEvent,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartScreenBloc>();
    final counters = bloc.state.counters;

    final productId = product.productId;
    if (productId == null) {
      return const SizedBox.shrink();
    }

    final baseUrl = dotenv.env['BASE_URL2'] ?? '';
    final imageUrl = (product.image?.startsWith('http') ?? false)
        ? product.image!
        : '$baseUrl${product.image ?? ''}';

    final productName = product.name?.orDash() ?? '-';
    final availableForDelivery = product.availableForDelivery ?? false;
    final brand = product.brand ?? 'Производитель';

    final count = cartType == CartType.defaultCart
        ? (counters[productId] ?? 1)
        : (product.count ?? 1);

    return BlocBuilder<FavoriteProductsScreenBloc, FavoriteProductsScreenState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: UiConstants.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF144B63).withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: -4,
                  offset: const Offset(-1, 4),
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
                          FavoriteButton(
                            isFav: state.products
                                .map((e) => e.productId)
                                .contains(product.productId),
                            onPressed: () {
                              if (product.productId != null) {
                                if (state.products
                                    .map((e) => e.productId)
                                    .contains(product.productId)) {
                                  context
                                      .read<FavoriteProductsScreenBloc>()
                                      .add(DeleteFavoriteProduct(
                                          productId: product.productId!));
                                } else {
                                  context
                                      .read<FavoriteProductsScreenBloc>()
                                      .add(UpdateFavoriteProducts(
                                          product: product));
                                }
                              }
                            },
                          ),
                          SizedBox(width: 12.w),
                          DeleteButton(onPressed: () {
                            bloc.add(
                                DeleteProductFromCart(productId: productId));
                          }),
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
                        imageUrl: imageUrl,
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
                                productName,
                                style: UiConstants.textStyle19.copyWith(
                                  color: availableForDelivery
                                      ? UiConstants.black3Color
                                      : UiConstants.black2Color,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                brand,
                                style: UiConstants.textStyle12.copyWith(
                                  height: 1,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                  color:
                                      UiConstants.black3Color.withOpacity(.6),
                                ),
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
                      if (availabilityType ==
                          PharmacyProductsAvailabilityType.available)
                        Expanded(
                          child: SizedBox(
                            height: 40.h,
                            child:
                                ProductPrice(fromCart: true, product: product),
                          ),
                        ),
                      SizedBox(width: 16.w),
                      if (availabilityType ==
                          PharmacyProductsAvailabilityType.available)
                        SizedBox(
                          height: 32,
                          child: CounterWidget(
                            count: count,
                            product: product,
                            onCountChanged: (id, newCount) {
                              final pickupBloc =
                                  context.read<OrderPickupCartScreenBloc>();
                              final state = pickupBloc.state;

                              if (cartType == CartType.pickupCart) {
                                final sameIdInCart = state.cartProducts
                                    .where((e) =>
                                        e.productId == id &&
                                        !identical(e, product))
                                    .map((e) => e.count ?? 1)
                                    .fold(0, (a, b) => a + b);

                                final sameIdInWarehouse = state
                                    .cartProductsFromWarehouse
                                    .where((e) =>
                                        e.productId == id &&
                                        !identical(e, product))
                                    .map((e) => e.count ?? 1)
                                    .fold(0, (a, b) => a + b);

                                final totalCount =
                                    newCount + sameIdInCart + sameIdInWarehouse;

                                bloc.add(UpdateProductCountEvent(
                                  product: product,
                                  count: totalCount,
                                ));
                              } else {
                                bloc.add(UpdateProductCountEvent(
                                  product: product,
                                  count: newCount,
                                ));
                              }

                              additionalEvent?.call();
                            },
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: getMarginOrPadding(top: 8),
                    child: product.specialOffer != null
                        ? (count >= (product.specialOffer?.count ?? 0)
                            ? AsGifetWidget(
                                product: product,
                                count: counters[productId] ?? 1,
                              )
                            : SpecialOfferBadgeWidget(
                                typeOfSpecialOffer: product.specialOffer!,
                              ))
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
