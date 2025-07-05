import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart'
    as fv;
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/products_screen/products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/sale_screen/sale_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/filter_and_sort_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/products_grid_widget.dart';
import 'package:nevis/features/presentation/widgets/sales_screen/sales_list_item.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key, this.promoId});
  final int? promoId;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => SaleScreenBloc(getPromotionUC: sl())..add(GetPromotionEvent(promotionId: promoId)),
          child: BlocBuilder<SaleScreenBloc, SaleScreenState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    justifyMultiLineText: false,
                    textBoneBorderRadius:
                        TextBoneBorderRadius.fromHeightFactor(.5),
                    enabled: state.isLoading,
                    child: Column(
                      children: [
                        CustomAppBar(
                          title: state.promotion?.title ?? 'Название акции',
                          showBack: true,
                          action: SvgPicture.asset(Paths.shareIconPath),
                        ),
                        Expanded(
                          child: ListView(
                            padding: getMarginOrPadding(
                                left: 20, right: 20, bottom: 90, top: 16),
                            children: [
                              if(state.promotion != null)SalesListItem(hasPharmaciesCount: false, promotion: state.promotion!,),
                              SizedBox(height: 16.h),
                              Text(
                                state.promotion?.description ?? 'Описание акции',
                                style: UiConstants.textStyle3.copyWith(
                                  color: UiConstants.black3Color
                                      .withOpacity(.6),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              BlocProvider(
                                create: (context) => ProductsScreenBloc(
                                  getCategoryProductsUC: sl(),
                                  getSortCategoryProductsUC: sl(),
                                  getSubCategoriesUC: sl(),
                                  products: state.promotion?.products ?? [],
                                  searchUC: sl(),
                                  productsCompilationUC: sl(),
                                )..add(LoadProductsEvent()),
                                child: BlocBuilder<ProductsScreenBloc,
                                    ProductsScreenState>(
                                  builder: (context, state) {
                                    final bloc =
                                        context.read<ProductsScreenBloc>();
                                    /*return Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.amber);*/
                                    return Column(
                                      children: [
                                        ListView(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          controller:
                                              bloc.productsController,
                                          children: [
                                            FilterSortContainer(
                                              isFromFav: false,
                                              sortTypes:
                                                  ProductSortType.values,
                                              selectedSortType:
                                                  state.selectedSortType,
                                              onSortSelected: (sortType) {
                                                bloc.add(
                                                    SelectSortProductsType(
                                                        productSortType:
                                                            sortType));
                                              },
                                              filterOrSortType: state
                                                  .selectedFilterOrSortType,
                                              onConfirmFilter: () => bloc.add(
                                                  ShowFilterProductsTypes()),
                                            ),

                                            SizedBox(height: 16.h),
                                            // Ваш контент
                                            if (state.isLoading)
                                              Center(
                                                  child:
                                                      CircularProgressIndicator())
                                            else if ((state.searchProducts
                                                        ?.products ??
                                                    [])
                                                .isEmpty)
                                              Center(
                                                  child: Text(
                                                      "Нет товаров в выбранной группе"))
                                            else
                                              BlocBuilder<
                                                  fv
                                                  .FavoriteProductsScreenBloc,
                                                  fv
                                                  .FavoriteProductsScreenState>(
                                                builder:
                                                    (context, favState) {
                                                  return ProductsGridWidget(
                                                    products: (state
                                                            .searchProducts
                                                            ?.products ??
                                                        []),
                                                    showCheckbox: false,
                                                    selectedProductIds: {},
                                                  );
                                                },
                                              ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
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
