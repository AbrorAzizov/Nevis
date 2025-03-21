import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/params/product_param.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/products_screen/products_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/products_grid_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final title = args['title'] as String?;
    final productParam = args['productParam'] as ProductParam?;
    final products = args['products'] as List<ProductEntity>?;
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        HomeScreenBloc homeBloc = context.read<HomeScreenBloc>();
        return BlocProvider(
          create: (context) => ProductsScreenBloc(
            searchProductsUC: sl(),
          )..add(
              LoadDataEvent(productParam, products),
            ),
          child: BlocBuilder<ProductsScreenBloc, ProductsScreenState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    enabled: state.isLoading,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                                controller: TextEditingController(),
                                showBack: true,
                                isShowFavoriteButton: true),
                            Expanded(
                              child: homeState is InternetUnavailable
                                  ? InternetNoInternetConnectionWidget()
                                  : ListView(
                                      shrinkWrap: true,
                                      padding: getMarginOrPadding(
                                          bottom: 94,
                                          right: 20,
                                          left: 20,
                                          top: 16),
                                      children: [
                                        Text(
                                          title ?? '-',
                                          style: UiConstants.textStyle9
                                              .copyWith(
                                                  color: UiConstants
                                                      .darkBlueColor),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          Utils.getProductCountText(
                                              (state.products ?? []).length),
                                          style:
                                              UiConstants.textStyle3.copyWith(
                                            color: UiConstants.darkBlue2Color
                                                .withOpacity(.6),
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        /* SortWidget(
                                          onTap: () => BottomSheetManager
                                              .showProductSortSheet(
                                                  homeBloc.context, context),
                                        ),*/
                                        SizedBox(height: 16.h),
                                        ProductsGridWidget(
                                            
                                            isLoading: state.isLoading,
                                            products: state.products ?? [], 
                                            selectedProductIds: {}, 
                                            showCheckbox: false,)
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
