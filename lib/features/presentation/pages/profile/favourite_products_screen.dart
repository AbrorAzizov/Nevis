import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/data/models/product_model.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/product_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/products_grid_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/sort_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoriteProductsScreen extends StatelessWidget {
  const FavoriteProductsScreen({super.key});

  Future<List<ProductEntity>> loadProductsFromJson() async {
    String jsonString = await rootBundle.loadString('assets/products.json');
    final data = jsonDecode(jsonString);
    List<dynamic> dataList = data['data'];
    return dataList.map((e) => ProductModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => FavoriteProductsScreenBloc(),
          child: BlocBuilder<FavoriteProductsScreenBloc,
              FavoriteProductsScreenState>(
            builder: (context, state) {
              final bloc = context.read<FavoriteProductsScreenBloc>();
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    enabled: false,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                              screenContext: context,
                              showBack: true,
                              controller: TextEditingController(),
                            ),
                            Expanded(
                              child: homeState is InternetUnavailable
                                  ? InternetNoInternetConnectionWidget()
                                  : FutureBuilder<List<dynamic>>(
                                      future: loadProductsFromJson(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  "Ошибка загрузки данных"));
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return SingleChildScrollView(
                                            padding:
                                                getMarginOrPadding(bottom: 94),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Text('Избранное',
                                                      style: UiConstants
                                                          .textStyle17),
                                                ),
                                                SizedBox(height: 8.h),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Text(
                                                    'В избранном пока нет товаров',
                                                    style: UiConstants
                                                        .textStyle11
                                                        .copyWith(
                                                      color: UiConstants
                                                          .black3Color
                                                          .withOpacity(.6),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8.h),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(Paths
                                                          .noFavoriteProductsIconPath),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 9.h),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: AppButtonWidget(
                                                      onTap: () {},
                                                      text: 'В каталог'),
                                                ),
                                                SizedBox(height: 16.h),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Рекомендуемые товары',
                                                          style: UiConstants
                                                              .textStyle18),
                                                      Row(
                                                        children: [
                                                          Text('Все'),
                                                          SizedBox(width: 4.w),
                                                          RotatedBox(
                                                            quarterTurns: 1,
                                                            child: SvgPicture
                                                                .asset(Paths
                                                                    .dropdownArrowIconPath),
                                                          ),
                                                          SizedBox(height: 16),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 16.h),
                                                // Горизонтальный ListView без паддинга
                                                SizedBox(
                                                  height: 380.h,
                                                  child: ListView.separated(
                                                    padding: getMarginOrPadding(
                                                        left: 20, right: 20),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: false,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        ProductWidget(
                                                            product: snapshot
                                                                .data![index]),
                                                    separatorBuilder: (context,
                                                            index) =>
                                                        SizedBox(width: 8.w),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return SingleChildScrollView(
                                            padding: getMarginOrPadding(
                                                bottom: 94,
                                                left: 20,
                                                right: 20),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 16.h),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: SortWidget(
                                                        text: 'Сортировка',
                                                        iconPath:
                                                            Paths.sortIconPath,
                                                        onTap: () {},
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: SortWidget(
                                                        text: 'Фильтр',
                                                        iconPath: Paths
                                                            .filtersIconPath,
                                                        onTap: () {},
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 16.h),
                                                CustomCheckbox(
                                                  title: Text(
                                                    'Выбрать все',
                                                    style: UiConstants
                                                        .textStyle8
                                                        .copyWith(
                                                            color: UiConstants
                                                                .blackColor),
                                                  ),
                                                  isChecked: state
                                                      .isAllProductsChecked,
                                                  onChanged: (_) => bloc.add(
                                                      PickAllProductsEvent(
                                                          productIds: (snapshot
                                                                      .data!
                                                                  as List<
                                                                      ProductEntity>)
                                                              .map((e) =>
                                                                  e.productId!)
                                                              .toSet())),
                                                ),
                                                SizedBox(height: 16.h),
                                                ProductsGridWidget(
                                                    isLoading: false,
                                                    products: snapshot.data
                                                        as List<ProductEntity>)
                                              ],
                                            ),
                                          );
                                        }
                                      },
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
