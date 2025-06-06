import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/order_pickup_screen/order_pickup_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/order_pickup_cart/order_pikcup_cart_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/favorite_pharmacies_screen/pharmacy_card.dart';
import 'package:nevis/features/presentation/widgets/map/pharmacy_map_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderPickupScreen extends StatefulWidget {
  const OrderPickupScreen({super.key});

  @override
  State<OrderPickupScreen> createState() => _OrderPickupScreenState();
}

class _OrderPickupScreenState extends State<OrderPickupScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<OrderPickupScreenBloc>().add(LoadPickupPharmaciesEvent());
    return BlocBuilder<OrderPickupScreenBloc, OrderPickupScreenState>(
        builder: (context, state) {
      final bloc = context.read<OrderPickupScreenBloc>();
      return Scaffold(
        backgroundColor: UiConstants.whiteColor,
        body: SafeArea(
          child: Skeletonizer(
            enabled: state.isLoading,
            child: Padding(
              padding: getMarginOrPadding(bottom: 87),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.pharmacies.isNotEmpty ||
                        (searchController.text.isNotEmpty &&
                            !state.isLoading &&
                            state.errorMessage == null)
                    ? [
                        CustomAppBar(
                          hintText: 'Поиск аптек',
                          controller: searchController,
                          title: 'Пункт самовывоза',
                          showBack: true,
                          isShowFavoriteButton: false,
                          onTapCancel: () {
                            searchController.clear();
                            bloc.add(PickupChangeQueryEvent(""));
                          },
                          onChangedField: (value) {
                            bloc.add(PickupChangeQueryEvent(value));
                          },
                        ),
                        Padding(
                          padding: getMarginOrPadding(left: 20, right: 20),
                          child: BlocProvider(
                            create: (context) =>
                                SelectorCubit(index: state.selectorIndex),
                            child: Selector(
                              titlesList: const ['Карта', 'Список'],
                              onTap: (int index) => bloc
                                  .add(PickupChangeSelectorIndexEvent(index)),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Expanded(
                          child: state.pharmacies.isEmpty &&
                                  searchController.text.isNotEmpty
                              ? Center(
                                  child: Text(
                                    'Нет совпадений',
                                    style: UiConstants.textStyle16,
                                  ),
                                )
                              : Stack(
                                  children: [
                                    state.selectorIndex != 0
                                        ? ListView.separated(
                                            padding: getMarginOrPadding(
                                                bottom: 94,
                                                left: 20,
                                                right: 20),
                                            itemBuilder: (context, index) =>
                                                PharmacyCard(
                                              onTap: () {
                                                bloc.add(
                                                    PickupPharmacySelectedEvent(
                                                        pharmacy:
                                                            state.pharmacies[
                                                                index]));
                                              },
                                              mapType: PharmacyMapType
                                                  .orderPickupMap,
                                              pharmacy: state.pharmacies[index],
                                            ),
                                            separatorBuilder:
                                                (context, index) =>
                                                    SizedBox(height: 8.h),
                                            itemCount: state.pharmacies.length,
                                          )
                                        : PharmacyMapWidget(
                                            points: state.points,
                                            mapType:
                                                PharmacyMapType.orderPickupMap,
                                          ),
                                    if (state.selectedPharmacy != null &&
                                        state.selectorIndex != 0)
                                      Positioned(
                                        left: 20,
                                        right: 20,
                                        bottom: 10,
                                        child: AppButtonWidget(
                                          text: 'Заберу отсюда',
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(Routes.createRoute(
                                              OrderPickupCartScreen(),
                                              settings: RouteSettings(
                                                arguments: {
                                                  'pharmacy':
                                                      state.selectedPharmacy
                                                },
                                                name: Routes
                                                    .orderPickupCartScreen,
                                              ),
                                            ));
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                      ]
                    : [
                        CustomAppBar(
                          title: 'Самовывоза',
                          showBack: true,
                          isShowFavoriteButton: false,
                        ),
                        SizedBox(height: 7.h),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    getMarginOrPadding(left: 20, right: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      'Нет доступных пунктов самовывоза',
                                      style: UiConstants.textStyle20,
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(Paths.noPharmaciesIconPath,
                                  width: 211, height: 211),
                              Padding(
                                padding:
                                    getMarginOrPadding(left: 20, right: 20),
                                child: AppButtonWidget(
                                  text: 'Найти на карте',
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
