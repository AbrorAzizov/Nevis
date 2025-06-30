import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/data/models/product_pharmacy_model.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/value_buy_product_screen/value_buy_product_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/profile/orders/successfully_order/value_buy_successfully_ordered_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
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
    final int productId = arguments['productId'] as int;

    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => ValueBuyProductScreenBloc(
              getBargainProductUC: sl(), bookBargainProductUC: sl())
            ..add(LoadDataEvent(productId: productId)),
          child: BlocConsumer<ValueBuyProductScreenBloc,
              ValueBuyProductScreenState>(
            listener: (context, state) {
              final bloc = context.read<ValueBuyProductScreenBloc>();
              if (state.bookingError != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.bookingError!)),
                );
                bloc.add(ClearBookingErrorEvent());
              } else if (state.bookResponse != null) {
                if (state.selectedPharmacyCard != null) {
                  Navigator.of(context).push(
                    Routes.createRoute(
                      const ValueBuySuccessfullyOrderedScreen(),
                      settings: RouteSettings(
                        name: Routes.valueBuySuccessfullyOrderedScreen,
                        arguments: {
                          'pharmacy': state.selectedPharmacyCard,
                          'order': state.bookResponse
                        },
                      ),
                    ),
                  );
                  bloc.add(ClearBookingResponseEvent());
                }
              }
            },
            builder: (context, state) {
              final bloc = context.read<ValueBuyProductScreenBloc>();

              final bool isList = state.selectorIndex == 1;
              final bool hasSelectedPharmacy =
                  state.selectedPharmacyCard != null;

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
                          enabled: state.isLoading,
                          child: Stack(
                            children: [
                              ListView(
                                shrinkWrap: true,
                                /*physics: !isList
                                    ? NeverScrollableScrollPhysics()
                                    : null,*/
                                padding: getMarginOrPadding(
                                    left: 20,
                                    right: 20,
                                    bottom: isList && hasSelectedPharmacy
                                        ? 130
                                        : 90),
                                children: [
                                  SizedBox(height: 20.h),
                                  ValueBuyProductCardWidget(
                                      product: state.bargainProduct?.item),
                                  SizedBox(height: 32.h),
                                  Text(
                                    'Доступные аптеки',
                                    style: UiConstants.textStyle16,
                                  ),
                                  SizedBox(height: 16.h),
                                  BlocProvider(
                                    create: (context) => SelectorCubit(
                                        index: state.selectorIndex),
                                    child: Selector(
                                      titlesList: const ['Карта', 'Список'],
                                      onTap: (int index) => bloc.add(
                                        ChangeSelectorIndexEvent(index),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  if (isList)
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
                                            bloc.add(ChangeQueryEvent(""));
                                          },
                                          onChangedField: (value) {
                                            bloc.add(ChangeQueryEvent(value));
                                          },
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              state.pharmacies?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            final pharmacy =
                                                state.pharmacies?[index];

                                            return GestureDetector(
                                              onTap: () {
                                                bloc.add(
                                                  PharmacyCardTappedEvent(
                                                    pharmacy: state
                                                        .pharmacies![index],
                                                  ),
                                                );
                                              },
                                              child: PharmacyProductInfoCard(
                                                isSelected: state
                                                        .selectedPharmacyCard ==
                                                    pharmacy,
                                                isForList: true,
                                                pharmacy: pharmacy!,
                                                onValueBuyPickUpCounters:
                                                    state.counters,
                                                onValueBuyPickUpChangedCount:
                                                    (newCounter) {
                                                  bloc.add(
                                                    UpdateCounterEvent(
                                                        pharmacyId: pharmacy
                                                            .pharmacyId!,
                                                        counter: newCounter),
                                                  );
                                                },
                                                onValueBuyPickUpRequested: () {
                                                  bloc.add(
                                                    BookBargainProductEvent(
                                                      productId:
                                                          productId.toString(),
                                                      pharmacyId: pharmacy
                                                          .pharmacyId!
                                                          .toString(),
                                                      quantity: state.counters[
                                                              pharmacy
                                                                  .pharmacyId] ??
                                                          1,
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(height: 8.h);
                                          },
                                        ),
                                      ],
                                    )
                                  else
                                    PharmacyMapWidget(
                                      mapType: PharmacyMapType.valueBuyMap,
                                      points: state.points,
                                      height: 600.h,
                                      selectedMarkerBuilder:
                                          (context, point, mapBloc) {
                                        final pharmacy =
                                            ProductPharmacyModel.fromJson(
                                                point.data!);

                                        return PharmacyProductInfoCard(
                                          pharmacy: pharmacy,
                                          onValueBuyPickUpCounters:
                                              state.counters,
                                          onValueBuyPickUpChangedCount:
                                              (int value) => bloc.add(
                                            UpdateCounterEvent(
                                                pharmacyId:
                                                    pharmacy.pharmacyId!,
                                                counter: value),
                                          ),
                                          onValueBuyPickUpRequested: () {
                                            bloc.add(BookBargainProductEvent(
                                                productId: productId.toString(),
                                                pharmacyId: pharmacy.pharmacyId!
                                                    .toString(),
                                                quantity: state.counters[
                                                        pharmacy.pharmacyId] ??
                                                    1));
                                          },
                                        );
                                      },
                                    ),
                                ],
                              ),
                              if (hasSelectedPharmacy && isList)
                                Positioned(
                                  left: 20.w,
                                  right: 20.w,
                                  bottom: 75.h,
                                  child: AppButtonWidget(
                                      onTap: () {
                                        final pharmacy =
                                            state.selectedPharmacyCard!;
                                        bloc.add(
                                          BookBargainProductEvent(
                                            productId: productId.toString(),
                                            pharmacyId:
                                                pharmacy.pharmacyId!.toString(),
                                            quantity: state.counters[
                                                    pharmacy.pharmacyId] ??
                                                1,
                                          ),
                                        );
                                      },
                                      text: 'Заберу отсюда',
                                      backgroundColor: UiConstants.blueColor),
                                ),
                            ],
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
