import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/value_buy_product_screen/value_buy_product_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/profile/orders/successfully_order/value_buy_successfully_ordered_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/map/pharmacy_map_widget.dart';
import 'package:nevis/features/presentation/widgets/value_buy_product_screen/product_card_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../widgets/value_buy_product_screen/pharmacy_product_info_card_widget.dart';

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
                            padding: getMarginOrPadding(
                                left: 20, right: 20, bottom: 90),
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
                                if (homeState is InternetUnavailable)
                                  InternetNoInternetConnectionWidget()
                                else if (valueBuyProductState.selectorIndex ==
                                    1)
                                  Column(
                                    children: [
                                      CustomAppBar(
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
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: valueBuyProductState
                                                .pharmacies?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          final pharmacy = valueBuyProductState
                                              .pharmacies![index];
                                          final counter =
                                              valueBuyProductState.counters[
                                                      pharmacy.pharmacyId] ??
                                                  1;

                                          return GestureDetector(
                                            onTap: () {
                                              valueBuyProductBloc.add(
                                                  PharmacyCardTappedEvent(
                                                      pharmacy:
                                                          valueBuyProductState
                                                                  .pharmacies![
                                                              index]));
                                            },
                                            child: PharmacyProductInfoCard(
                                              isSelected: valueBuyProductState
                                                      .selectedPharmacyCard ==
                                                  valueBuyProductState
                                                      .pharmacies![index],
                                              isForList: true,
                                              pharmacy: valueBuyProductState
                                                  .pharmacies![index],
                                              counter: counter,
                                              onCounterChanged: (newCounter) {
                                                valueBuyProductBloc.add(
                                                  UpdateCounterEvent(
                                                    pharmacyId:
                                                        pharmacy.pharmacyId!,
                                                    counter: newCounter,
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(height: 8.h);
                                        },
                                      ),
                                      SizedBox(height: 16),
                                      AppButtonWidget(
                                        onTap: valueBuyProductState
                                                    .selectedPharmacyCard !=
                                                null
                                            ? () {
                                                Navigator.of(context).push(
                                                  Routes.createRoute(
                                                    const ValueBuySuccessfullyOrderedScreen(),
                                                    settings: RouteSettings(
                                                      name: Routes
                                                          .valueBuySuccessfullyOrderedScreen,
                                                      arguments: {
                                                        'pharmacy':
                                                            valueBuyProductState
                                                                .selectedPharmacyCard
                                                      },
                                                    ),
                                                  ),
                                                );
                                                // ValueBuySuccessfullyOrderedScreen
                                              }
                                            : null,
                                        text: 'Заберу отсюда',
                                        backgroundColor: UiConstants.blueColor,
                                      ),
                                    ],
                                  )
                                else if (valueBuyProductState.selectorIndex ==
                                        0 &&
                                    valueBuyProductState.points.isNotEmpty)
                                  PharmacyMapWidget(
                                    height: 618.h,
                                    fromProduct: true,
                                    points: valueBuyProductState.points,
                                  ),
                              ],
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
