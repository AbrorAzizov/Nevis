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
        SizedBox(
          height: 260.h,
          child: PageView.builder(
            controller: pageController,
            itemCount: 1,
            itemBuilder: (context, index) =>
                ProductBannerItem(product: product),
          ),
        ),
        Skeleton.ignore(
          child: Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: getMarginOrPadding(top: 8),
              child: SmoothPageIndicator(
                controller: pageController,
                count: 1,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                    spacing: 4.w,
                    dotWidth: 6.w,
                    dotHeight: 6.w,
                    dotColor: UiConstants.white4Color,
                    activeDotColor: UiConstants.darkBlueColor.withOpacity(.6)),
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
