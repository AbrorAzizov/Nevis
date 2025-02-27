import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/pages/catalog/products/product_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/product_price.dart';
import 'package:nevis/features/presentation/widgets/product_chip_widget.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_sale_chip.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        Routes.createRoute(
          const ProductScreen(),
          settings: RouteSettings(
              name: Routes.productScreen, arguments: product.productId),
        ),
      ),
      child: Container(
        width: 148.w,
        decoration: BoxDecoration(
          color: UiConstants.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: CachedNetworkImage(
                    height: 112.h,
                    width: double.infinity,
                    imageUrl: '${dotenv.env['PUBLIC_URL']!}${product.image}',
                    fit: BoxFit.fitHeight,
                    cacheManager: CustomCacheManager(),
                    errorWidget: (context, url, error) => SvgPicture.asset(
                        Paths.drugTemplateIconPath,
                        height: double.infinity),
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                          color: UiConstants.pink2Color),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: getMarginOrPadding(all: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name ?? '',
                            style: UiConstants.textStyle8
                                .copyWith(color: UiConstants.darkBlueColor),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ProductPrice(product: product),
                            if (product.discount != null)
                              ProductSaleChip(discount: product.discount ?? 0)
                          ],
                        ),
                        Spacer(),
                        AppButtonWidget(
                          isActive: true,
                          text: 'В корзину',
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 4.h,
              left: 8.w,
              right: 8.w,
              child: Wrap(
                spacing: 4.w,
                runSpacing: 4.w,
                children: [
                  if (product.discount != null)
                    ProductChipWidget(productChipType: ProductChipType.stock),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
