import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';
import 'package:nevis/features/presentation/widgets/filter_and_sort_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/products_grid_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoriteProductsScreen extends StatelessWidget {
  const FavoriteProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteProductsScreenBloc, FavoriteProductsScreenState>(
      builder: (context, state) {
        final bloc = context.read<FavoriteProductsScreenBloc>();
        return Scaffold(
          backgroundColor: UiConstants.backgroundColor,
          body: SafeArea(
            child: Skeletonizer(
              ignorePointers: false,
              enabled: false,
              child: Column(
                children: [
                  CustomAppBar(
                    screenContext: context,
                    showBack: true,
                    controller: TextEditingController(),
                  ),
                  Expanded(
                    child: () {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.error != null) {
                        return const Center(
                            child: Text("Ошибка загрузки данных"));
                      } else if (state.products.isEmpty) {
                        return SingleChildScrollView(
                          padding: getMarginOrPadding(bottom: 94),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text('Избранное',
                                    style: UiConstants.textStyle17),
                              ),
                              SizedBox(height: 8.h),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'В избранном пока нет товаров',
                                  style: UiConstants.textStyle11.copyWith(
                                    color:
                                        UiConstants.black3Color.withOpacity(.6),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Center(
                                  child: Image.asset(
                                      Paths.noFavoriteProductsIconPath)),
                              SizedBox(height: 9.h),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: AppButtonWidget(
                                    onTap: () {
                                      final homeBloc =
                                          context.read<HomeScreenBloc>();
                                      homeBloc
                                          .navigatorKeys[
                                              homeBloc.selectedPageIndex]
                                          .currentState!
                                          .popUntil((route) => route.isFirst);
                                      homeBloc.add(ChangePageEvent(1));
                                    },
                                    text: 'В каталог'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return SingleChildScrollView(
                          padding: getMarginOrPadding(
                              bottom: 94, left: 20, right: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 16.h),
                              FilterSortContainer(
                                isFromFav: true,
                                sortTypes: ProductSortType.values,
                                selectedSortType: state.selectedSortType,
                                onSortSelected: (sortType) {
                                  bloc.add(SelectSortProductsType(
                                      productSortType: sortType));
                                },
                                filterOrSortType:
                                    state.selectedFilterOrSortType,
                                onConfirmFilter: () =>
                                    bloc.add(ShowFilterProductsTypes()),
                              ),
                              SizedBox(height: 16.h),
                              CustomCheckbox(
                                title: Text(
                                  'Выбрать все',
                                  style: UiConstants.textStyle8.copyWith(
                                    color: UiConstants.blackColor,
                                  ),
                                ),
                                isChecked: state.isAllProductsChecked,
                                onChanged: (_) =>
                                    bloc.add(PickAllProductsEvent()),
                              ),
                              SizedBox(height: 16.h),
                              ProductsGridWidget(
                                products: state.products,
                                selectedProductIds: state.selectedProductIds,
                                showCheckbox: true,
                              ),
                              SizedBox(height: 10.h),
                              if (state.selectedProductIds.isNotEmpty)
                                Column(
                                  children: [
                                    // SelectedProductsPriceInformationWidget(
                                    //   products: state.products
                                    //       .where((product) => state
                                    //           .selectedProductIds
                                    //           .contains(product.productId))
                                    //       .toList(),

                                    // ),
                                    SizedBox(height: 16.h),
                                    AppButtonWidget(
                                      text: 'Добавить 2 товара в корзину',
                                      onTap: () {},
                                      isFilled: false,
                                      textColor: UiConstants.blueColor,
                                      showBorder: true,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      }
                    }(),
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
