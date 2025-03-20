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
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/product_widget.dart';
import 'package:nevis/features/presentation/widgets/search_product_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavouriteProductsScreen extends StatelessWidget {
  const FavouriteProductsScreen({super.key});

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
                      SearchProductAppBar(
                        onTapFavoriteProductsChip: () {},
                        screenContext: context,
                        onTapLocationChip: () {},
                      ),
                      Expanded(
                        child: homeState is InternetUnavailable
                            ? InternetNoInternetConnectionWidget()
                            : FutureBuilder<List<dynamic>>(
                                future: loadProductsFromJson(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text("Ошибка загрузки данных"));
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Center(child: Text("Нет данных"));
                                  } else {
                                    return
                                        SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Добавил паддинг
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
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(Paths.noFavouriteProductsIconPath),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 9.h),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: AppButtonWidget(onTap: () {}, text: 'В каталог'),
                                              ),
                                              SizedBox(height: 16.h),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Рекомендуемые товары', style: UiConstants.textStyle18),
                                                    Row(
                                                      children: [
                                                        Text('Все'),
                                                        SizedBox(width: 4.w),
                                                        RotatedBox(
                                                          quarterTurns: 1,
                                                          child: SvgPicture.asset(Paths.dropdownArrowIconPath),
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
                                                 height: 450.h,  
                                                 child: ListView.builder(
                                                    
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.horizontal,
                                                    shrinkWrap: false,
                                                    physics: BouncingScrollPhysics(),
                                                    itemCount: snapshot.data!.length,
                                                    itemBuilder: (context, index) =>
                                                        ProductWidget(product: snapshot.data![index]),
                                                  ),
                                               ),
                                             
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
    );
  }
}