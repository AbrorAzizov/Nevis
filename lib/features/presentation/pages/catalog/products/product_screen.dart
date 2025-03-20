import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/bottom_sheet_manager.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/product_screen/product_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/products_list_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/dropdown_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_banner_widget.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_characteristic_widget.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_receiving_methods_widget.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_title_widget.dart';
import 'package:nevis/locator_service.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int? productId = ModalRoute.of(context)!.settings.arguments as int?;
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        final homeBloc = context.read<HomeScreenBloc>();
        return BlocProvider(
          create: (context) => ProductScreenBloc(
              productId: productId,
              getOneProductUC: sl(),
              getProductPharmaciesUC: sl())
            ..add(LoadDataEvent()),
          child: BlocBuilder<ProductScreenBloc, ProductScreenState>(
            builder: (context, state) {
              final productBloc = context.read<ProductScreenBloc>();
              return Scaffold(
                appBar: AppBar(
                    toolbarHeight: 0,
                    backgroundColor: UiConstants.whiteColor,
                    surfaceTintColor: Colors.transparent),
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    justifyMultiLineText: false,
                    textBoneBorderRadius:
                        TextBoneBorderRadius.fromHeightFactor(.5),
                    enabled: state.isLoading,
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
                                  : Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        ListView(
                                          shrinkWrap: true,
                                          padding: getMarginOrPadding(
                                              bottom: 120, top: 16),
                                          children: [
                                            ProductBannerWidget(
                                                pageController:
                                                    productBloc.pageController,
                                                product: state.product),
                                            SizedBox(height: 16.h),
                                            Padding(
                                              padding: getMarginOrPadding(
                                                  left: 20, right: 20),
                                              child: ProductTitleWidget(
                                                  product: state.product),
                                            ),
                                            SizedBox(height: 16.h),
                                            Padding(
                                              padding: getMarginOrPadding(
                                                  left: 20, right: 20),
                                              child:
                                                  ProductReceivingMethodsWidget(
                                                pharmacies:
                                                    state.pharmacies ?? [],
                                              ),
                                            ),
                                            SizedBox(height: 16.h),
                                            Padding(
                                              padding: getMarginOrPadding(
                                                  left: 20, right: 20),
                                              child: DropdownWidget(
                                                title: 'Характеристики',
                                                child:
                                                    ProductCharacteristicWidget(
                                                        product: state.product),
                                              ),
                                            ),
                                            SizedBox(height: 16.h),
                                            Padding(
                                              padding: getMarginOrPadding(
                                                  left: 20, right: 20),
                                              child: DropdownWidget(
                                                title: 'Описание',
                                                child: Skeleton.replace(
                                                  child: Html(
                                                    data: state.isLoading
                                                        ? Utils.mockHtml
                                                        : state.product
                                                                ?.description ??
                                                            '-',
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
                                                          blockStart:
                                                              HtmlPadding(0),
                                                          blockEnd:
                                                              HtmlPadding(0),
                                                        ),
                                                      ),
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 32.h),
                                            BlockWidget(
                                              contentPadding:
                                                  getMarginOrPadding(
                                                      left: 20, right: 20),
                                              title: 'Аналоги',
                                              onTap: () {},
                                              child: ProductsListWidget(
                                                  products: [], productsListScreenType: ProductsListScreenType.pharmacy,),
                                            ),
                                            SizedBox(height: 32.h),
                                          ],
                                        ),
                                        Positioned(
                                          left: 20.w,
                                          right: 20.w,
                                          bottom: 94,
                                          child: (state.pharmacies ?? [])
                                                  .isEmpty
                                              ? AppButtonWidget(
                                                  text:
                                                      'Сообщить о поступлении',
                                                  onTap: () => BottomSheetManager
                                                      .showProductReceiptNotificationSheet(
                                                          homeBloc.context),
                                                )
                                              : AppButtonWidget(
                                                  text: 'В корзину',
                                                  onTap: () {},
                                                ),
                                        ),
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
