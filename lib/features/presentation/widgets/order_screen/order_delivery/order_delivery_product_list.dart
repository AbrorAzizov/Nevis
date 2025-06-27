import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';

class OrderDeliveryProductList extends StatefulWidget {
  final List<ProductEntity> items;
  const OrderDeliveryProductList({super.key, required this.items});

  @override
  State<OrderDeliveryProductList> createState() =>
      _OrderDeliveryProductListState();
}

class _OrderDeliveryProductListState extends State<OrderDeliveryProductList>
    with TickerProviderStateMixin {
  bool _expanded = false;

  void _toggleVisibility() => setState(() => _expanded = true);

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final int hiddenCount = items.length > 2 ? items.length - 2 : 0;
    final List<ProductEntity> visibleItems =
        _expanded ? items : items.take(2).toList();
    final baseUrl = dotenv.env['BASE_URL2'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = visibleItems[index];
              final imageUrl = '$baseUrl${item.image ?? ''}';
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 56,
                    width: 56,
                    cacheManager: CustomCacheManager(),
                    errorWidget: (context, url, error) => Icon(Icons.image,
                        size: 18.w, color: UiConstants.whiteColor),
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                          color: UiConstants.blueColor),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.name ?? '',
                      style: UiConstants.textStyle21
                          .copyWith(color: UiConstants.black3Color),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    '${item.count ?? 1} шт',
                    style: UiConstants.textStyle19
                        .copyWith(color: UiConstants.black3Color),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(color: UiConstants.black3Color.withOpacity(.1)),
            ),
            itemCount: visibleItems.length,
          ),
        ),
        if (hiddenCount > 0 && !_expanded)
          GestureDetector(
            onTap: _toggleVisibility,
            child: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Row(
                children: [
                  Text(
                    'Ещё ($hiddenCount)',
                    style: UiConstants.textStyle3.copyWith(
                      color: UiConstants.black3Color.withOpacity(.6),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.0 : 0.5,
                    duration: const Duration(milliseconds: 300),
                    child: SvgPicture.asset(
                      Paths.dropdownArrowIconPath,
                      width: 24.w,
                      height: 24.w,
                      color: UiConstants.black3Color.withOpacity(.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
