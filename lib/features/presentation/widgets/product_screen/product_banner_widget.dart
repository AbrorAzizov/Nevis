import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_banner_item.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductBannerWidget extends StatelessWidget {
  const ProductBannerWidget(
      {super.key, required this.pageController, required this.product});

  final PageController pageController;
  final ProductEntity? product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: getMarginOrPadding(),
          child: Container(
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
            height: 320.h,
            width: 320.w,
            child: PageView.builder(
              controller: pageController,
              itemCount: product?.images?.length,
              itemBuilder: (context, index) => Container(
                child: ProductBannerItem(product: product),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: getMarginOrPadding(left: 20, right: 20),
          child: Text(
            '*Внешний вид товара может отличаться от изображенного на фото',
            style: UiConstants.textStyle15,
          ),
        ),
        Skeleton.ignore(
          child: Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: getMarginOrPadding(top: 8),
              child: SmoothPageIndicator(
                controller: pageController,
                count: product?.images?.length ?? 1,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                    spacing: 4.w,
                    dotWidth: 24.w,
                    dotHeight: 6.w,
                    dotColor: UiConstants.white4Color,
                    activeDotColor: UiConstants.blueColor.withOpacity(.6)),
                onDotClicked: (index) => pageController.animateToPage(index,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear),
              ),
            ),
          ),
        )
      ],
    );
  }
}
