import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/presentation/bloc/banner_screen/banner_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/products_list_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/banner_item.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';

import 'package:skeletonizer/skeletonizer.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  bool isLoading = true;
  late Timer _timer;
  String? _htmlContent;

  @override
  void initState() {
    super.initState();
    _loadHtmlFromAssets();
    _timer = Timer(Duration(seconds: 5), () {
      _timer.cancel();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future _loadHtmlFromAssets() async {
    String htmlString =
        await rootBundle.loadString('assets/html/banner_info.html');
    setState(() {
      _htmlContent = htmlString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => BannerScreenBloc(),
          child: BlocBuilder<BannerScreenBloc, BannerScreenState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    justifyMultiLineText: false,
                    textBoneBorderRadius:
                        TextBoneBorderRadius.fromHeightFactor(.5),
                    enabled: isLoading,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                              showBack: true,
                              action: SvgPicture.asset(Paths.shareIconPath),
                            ),
                            Expanded(
                              child: homeState is InternetUnavailable
                                  ? InternetNoInternetConnectionWidget()
                                  : ListView(
                                      shrinkWrap: true,
                                      padding: getMarginOrPadding(
                                          bottom: 94, top: 16),
                                      children: [
                                        Padding(
                                          padding: getMarginOrPadding(
                                              left: 20, right: 20),
                                          child: BannerItem(),
                                        ),
                                        SizedBox(height: 16.h),
                                        Padding(
                                          padding: getMarginOrPadding(
                                              left: 20, right: 20),
                                          child: Text(
                                            'Избавляемся от высыпаний с косметикой URIAGE прямиком из Франции!',
                                            style: UiConstants.textStyle5
                                                .copyWith(
                                                    color: UiConstants
                                                        .darkBlueColor),
                                          ),
                                        ),
                                        if (Skeletonizer.of(context).enabled)
                                          SizedBox(height: 16.h),
                                        Skeleton.replace(
                                          child: Padding(
                                            padding: getMarginOrPadding(
                                                left: 20, right: 20),
                                            child: Html(
                                              data: _htmlContent ?? '',
                                              style: {
                                                "p": Utils.htmlStyle,
                                                "li": Utils.htmlStyle,
                                                "*": Style(
                                                  margin: Margins(
                                                    blockStart: Margin(0),
                                                    blockEnd: Margin(0),
                                                    left: Margin(0),
                                                    right: Margin(0),
                                                  ),
                                                  padding: HtmlPaddings(
                                                    blockStart: HtmlPadding(0),
                                                    blockEnd: HtmlPadding(0),
                                                  ),
                                                ),
                                              },
                                            ),
                                          ),
                                        ),
                                        BlockWidget(
                                          contentPadding: getMarginOrPadding(
                                              left: 20, right: 20),
                                          title: 'Рекомендуемые товары',
                                          onTap: () {},
                                          child: ProductsListWidget(
                                            products: [], productsListScreenType: ProductsListScreenType.pharmacy,
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
