import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/value_buy_product_screen/value_buy_product_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/map/pharmacy_map_widget.dart';
import 'package:nevis/features/presentation/widgets/value_buy_product_screen/product_card_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ValueBuyProductScreen extends StatefulWidget {
  const ValueBuyProductScreen({super.key});

  @override
  State<ValueBuyProductScreen> createState() => _ValueBuyProductScreenState();
}

class _ValueBuyProductScreenState extends State<ValueBuyProductScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final ProductEntity product = arguments['product'] as ProductEntity;
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) =>
              ValueBuyProductScreenBloc(getProductPharmaciesUC: sl())
                ..add(LoadDataEvent(productId: product.productId!)),
          child: BlocBuilder<ValueBuyProductScreenBloc,
              ValueBuyProductScreenState>(
            builder: (context, valueBuyProductState) {
              ValueBuyProductScreenBloc valueBuyProductBloc =
                  context.read<ValueBuyProductScreenBloc>();
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Column(
                    children: [
                      CustomAppBar(
                        title: 'Купить выгодно',
                        showBack: true,
                        isShowFavoriteButton: false,
                      ),
                      Expanded(
                        child: Skeletonizer(
                          ignorePointers: false,
                          enabled: valueBuyProductState.isLoading,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Padding(
                              padding: getMarginOrPadding(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20.h),
                                  ValueBuyProductCardWidget(product: product),
                                  SizedBox(height: 32.h),
                                  Text(
                                    'Доступные аптеки',
                                    style: UiConstants.textStyle16,
                                  ),
                                  SizedBox(height: 16.h),
                                  BlocProvider(
                                    create: (context) => SelectorCubit(
                                        index:
                                            valueBuyProductState.selectorIndex),
                                    child: Selector(
                                      titlesList: const ['Карта', 'Список'],
                                      onTap: (int index) =>
                                          valueBuyProductBloc.add(
                                        ChangeSelectorIndexEvent(index),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  valueBuyProductState.selectorIndex == 1
                                      ? CustomAppBar(
                                          usePadding: false,
                                          hintText: 'Поиск аптек',
                                          controller: searchController,
                                          showBack: false,
                                          isShowFavoriteButton: false,
                                          onTapCancel: () {
                                            searchController.clear();
                                            valueBuyProductBloc
                                                .add(ChangeQueryEvent(""));
                                          },
                                          onChangedField: (value) {
                                            valueBuyProductBloc
                                                .add(ChangeQueryEvent(value));
                                          },
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(
                                    child: Builder(
                                      builder: (context) {
                                        if (homeState is InternetUnavailable) {
                                          return InternetNoInternetConnectionWidget();
                                        }
                                        if (valueBuyProductState
                                                    .selectorIndex ==
                                                0 &&
                                            valueBuyProductState
                                                .points.isNotEmpty) {
                                          return PharmacyMapWidget(
                                              height: 618.h,
                                              fromProduct: true,
                                              points:
                                                  valueBuyProductState.points);
                                        }
                                        return SizedBox.shrink();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
