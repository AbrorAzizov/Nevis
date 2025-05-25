import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/product_screen/product_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/dropdown_widget.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_banner_widget.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_receiving_methods_widget.dart';
import 'package:nevis/features/presentation/widgets/product_screen/product_title_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/product_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final productId = arguments['productId'];
    final categoryId = arguments['categoryId'];

    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (_) => ProductScreenBloc(
            getOneProductUC: sl(),
            getProductPharmaciesUC: sl(),
            getRecomendationProductsUC: sl(),
          )..add(LoadDataEvent(productId: productId, categoryId: categoryId)),
          child: BlocBuilder<ProductScreenBloc, ProductScreenState>(
            builder: (context, state) {
              final productBloc = context.read<ProductScreenBloc>();
              return Scaffold(
                backgroundColor: UiConstants.whiteColor,
                body: SafeArea(
                  child: Skeletonizer(
                    enabled: state.isLoading,
                    textBoneBorderRadius:
                        TextBoneBorderRadius.fromHeightFactor(.5),
                    child: Column(
                      children: [
                        CustomAppBar(
                          title: state.product?.name ?? '',
                          showBack: true,
                          action: SvgPicture.asset(Paths.shareIconPath),
                        ),
                        Expanded(
                          child: ListView(
                            padding: getMarginOrPadding(bottom: 71),
                            children: [
                              SizedBox(height: 16.h),
                              if (state.product != null)
                                ProductBannerWidget(
                                  pageController: productBloc.pageController,
                                  product: state.product,
                                ),
                              SizedBox(height: 16.h),
                              Padding(
                                padding:
                                    getMarginOrPadding(left: 20, right: 20),
                                child: state.isLoading
                                    ? Skeleton.shade(
                                        child: ProductTitleWidget(),
                                      )
                                    : ProductTitleWidget(
                                        product: state.product,
                                      ),
                              ),
                              SizedBox(height: 16.h),
                              Padding(
                                padding:
                                    getMarginOrPadding(left: 20, right: 20),
                                child: ProductReceivingMethodsWidget(
                                  pharmacies: state.pharmacies ?? [],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Padding(
                                padding:
                                    getMarginOrPadding(left: 20, right: 20),
                                child: AppButtonWidget(
                                  text: 'Купить сейчас',
                                  onTap: () {},
                                ),
                              ),
                              Padding(
                                padding: getMarginOrPadding(
                                    left: 20, right: 20, top: 8),
                                child: AppButtonWidget(
                                  isFilled: false,
                                  showBorder: true,
                                  text: 'Добавить в корзину',
                                  textColor: UiConstants.blueColor,
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding:
                                    getMarginOrPadding(left: 20, right: 20),
                                child: DropdownWidget(
                                  title: 'Описание',
                                  child: Skeleton.replace(
                                    child: Html(
                                      data: state.isLoading
                                          ? Utils.mockHtml
                                          : state.product?.description ?? '-',
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
                                        ),
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Padding(
                                padding: getMarginOrPadding(left: 20),
                                child: Text(
                                  'C этим товаром покупают',
                                  style: UiConstants.textStyle5.copyWith(
                                    color: UiConstants.black2Color,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              if ((state.recomendationProducts?.products ?? [])
                                  .isNotEmpty)
                                SizedBox(
                                  height: 390.h,
                                  child: BlocBuilder<FavoriteProductsScreenBloc,
                                      FavoriteProductsScreenState>(
                                    builder: (context, favState) {
                                      return ListView.builder(
                                          padding: getMarginOrPadding(
                                              left: 20, right: 20),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: (state
                                                      .recomendationProducts
                                                      ?.products ??
                                                  [])
                                              .length,
                                          itemBuilder: (context, index) {
                                            return ProductWidget(
                                                categoryId: categoryId,
                                                product: (state
                                                        .recomendationProducts
                                                        ?.products ??
                                                    [])[index],
                                                isSelected: false,
                                                showCheckbox: false);
                                          });
                                    },
                                  ),
                                ),
                              SizedBox(
                                height: 16.h,
                              )
                            ],
                          ),
                        ),
                      ],
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
