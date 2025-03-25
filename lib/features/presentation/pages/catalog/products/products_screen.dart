import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/params/product_param.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/products_screen/products_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/favourite_products_screen/selected_products_price_info_widget.dart';
import 'package:nevis/features/presentation/widgets/filter_and_sort_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/products_grid_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';


class ProdcutsScreen extends StatelessWidget {
  const ProdcutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsScreenBloc(searchProductsUC: sl())..add(LoadDataEvent()),
      child:
          BlocBuilder<ProductsScreenBloc, ProductsScreenState>(
        builder: (context, state) {
          final bloc = context.read<ProductsScreenBloc>();

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
                      child: _buildBody(state, bloc),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
      ProductsScreenState state, ProductsScreenBloc bloc) {
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state.error != null) {
      return Center(child: Text("Ошибка загрузки данных"));
    } else if (state.products.isEmpty) {
      return _buildEmptyFavorites();
    } else {
      return _buildProductList(state, bloc);
    }
  }

  Widget _buildEmptyFavorites() {
    return SingleChildScrollView(
      padding: getMarginOrPadding(bottom: 94),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Избранное', style: UiConstants.textStyle17),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'В избранном пока нет товаров',
              style: UiConstants.textStyle11.copyWith(
                color: UiConstants.black3Color.withOpacity(.6),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Center(child: Image.asset(Paths.noFavoriteProductsIconPath)),
          SizedBox(height: 9.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: AppButtonWidget(onTap: () {}, text: 'В каталог'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(
      ProductsScreenState state, ProductsScreenBloc bloc) {
    return SingleChildScrollView(
      padding: getMarginOrPadding(bottom: 94, left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          FilterSortContainer(
            sortTypes: ProductSortType.values,
            selectedSortType: state.selectedSortType,
            onSortSelected: (sortType) {
              bloc.add(SelectSortProductsType(productSortType: sortType));
            },
            filterOrSortType: state.selectedFilterOrSortType,
            onConfirmFilter: () => bloc.add(ShowFilterProductsTypes()),
          ),
          SizedBox(height: 16.h),
          CustomCheckbox(
            title: Text(
              'Выбрать все',
              style: UiConstants.textStyle8
                  .copyWith(color: UiConstants.blackColor),
            ),
            isChecked: state.isAllProductsChecked,
            onChanged: (_) => bloc.add(PickAllProductsEvent()),
          ),
          SizedBox(height: 16.h),
          ProductsGridWidget(
              isLoading: false,
              products: state.products,
              selectedProductIds: state.selectedProductIds,
              showCheckbox: true),
          SizedBox(height: 10.h),
          if (state.selectedProductIds.isNotEmpty)
            Column(
              children: [
                SelectedProductsPriceInformationWidget(
                  products: state.products
                      .where((product) =>
                          state.selectedProductIds.contains(product.productId))
                      .toList(),
                ),
                SizedBox(height: 16.h),
                AppButtonWidget(
                  text: 'Добавить 2 товара в корзину',
                  onTap: () {},
                  isFilled: false,
                  textColor: UiConstants.blueColor,
                  showBorder: true,
                )
              ],
            )
        ],
      ),
    );
  }
}
