import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/banner_entity.dart';
import 'package:nevis/features/presentation/pages/main/banner_screen.dart';
import 'package:nevis/features/presentation/widgets/main_screen/banner_item.dart';

import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomBannerWidget extends StatefulWidget {
  const CustomBannerWidget({
    super.key,
    required this.pageController,
    required this.banners,
  });
  final List<BannerEntity> banners;
  final PageController pageController;

  @override
  State<CustomBannerWidget> createState() => _CustomBannerWidgetState();
}

class _CustomBannerWidgetState extends State<CustomBannerWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _stopAutoScroll();
    // _timer = Timer.periodic(Duration(seconds: 5), (timer) {
    //   if (widget.pageController.hasClients) {
    //     final nextPage = (widget.pageController.page?.toInt() ?? 0) + 1;
    //     widget.pageController.animateToPage(
    //       nextPage % widget.banners.length,
    //       duration: Duration(milliseconds: 300),
    //       curve: Curves.easeInOut,
    //     );
    //   }
    // });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopAutoScroll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 184.h,
          child: PageView.builder(
            controller: widget.pageController,
            itemCount: widget.banners.length,
            onPageChanged: (_) {
              // Сбрасываем таймер при ручном пролистывании
              _startAutoScroll();
            },
            itemBuilder: (context, index) => FractionallySizedBox(
              widthFactor: 1 / widget.pageController.viewportFraction,
              child: Padding(
                padding: getMarginOrPadding(right: 20, left: 20),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    Routes.createRoute(
                      const BannerScreen(),
                      settings: RouteSettings(name: Routes.bannerScreen),
                    ),
                  ),
                  child: BannerItem(
                    url:
                        '${dotenv.env['PUBLIC_URL']!}${widget.banners[index].image}',
                  ),
                ),
              ),
            ),
          ),
        ),
        // Skeleton.ignore(
        //   child: Align(
        //     alignment: AlignmentDirectional.center,
        //     child: Padding(
        //       padding: getMarginOrPadding(top: 8),
        //       child: SmoothPageIndicator(
        //         controller: widget.pageController,
        //         count: widget.banners.length,
        //         axisDirection: Axis.horizontal,
        //         effect: WormEffect(
        //           spacing: 4.w,
        //           dotWidth: 6.w,
        //           dotHeight: 6.w,
        //           dotColor: UiConstants.white4Color,
        //           activeDotColor: UiConstants.darkBlueColor.withOpacity(.6),
        //         ),
        //         onDotClicked: (index) {
        //           widget.pageController.animateToPage(
        //             index,
        //             duration: Duration(milliseconds: 200),
        //             curve: Curves.linear,
        //           );
        //           // Сбрасываем таймер при клике на индикатор
        //           _startAutoScroll();
        //         },
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
