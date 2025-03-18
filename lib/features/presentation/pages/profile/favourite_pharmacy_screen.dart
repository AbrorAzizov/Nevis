import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/presentation/bloc/favourite_pharmacies_screen/bloc/favourite_pharmacies_bloc_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/favourite_pharmacies_screen/pharmacy_info_card.dart';
import 'package:nevis/features/presentation/widgets/map/map_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class FavouritePharmaciesScreen extends StatefulWidget {
  const FavouritePharmaciesScreen({super.key});

  @override
  State<FavouritePharmaciesScreen> createState() =>
      _FavouritePharmaciesScreenState();
}

class _FavouritePharmaciesScreenState extends State<FavouritePharmaciesScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => FavouritePharmaciesBloc(getPharmaciesUC: sl())
            ..add(LoadDataEvent()),
          child: BlocBuilder<FavouritePharmaciesBloc, FavouritePharmaciesState>(
            builder: (context, pharmaciesState) {
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    enabled: pharmaciesState is FavouritePharmaciesLoading,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                              hintText: 'Поиск аптек',
                              controller: searchController,
                              title: 'Аптеки',
                              showBack: true,
                              isShowFilterButton: false,
                              onTapCancel: () {
                                searchController.clear();
                              },
                            ),
                            Padding(
                              padding: getMarginOrPadding(left: 20, right: 20),
                              child: BlocProvider(
                                create: (context) => SelectorCubit(
                                    index: pharmaciesState.selectorIndex),
                                child: Selector(
                                    titlesList: const ['Карта', 'Список'],
                                    onTap: (int index) {}),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            if (pharmaciesState is FavouritePharmaciesLoaded)
                              Padding(
                                  padding: getMarginOrPadding(
                                      top: 16, bottom: 16, left: 20, right: 20),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      /// Карта
                                      MapWidget(
                                          mapObjects:
                                              pharmaciesState.mapObjects),

                                      if (pharmaciesState.selectedPharmacy !=
                                          null)
                                        PharmacyInfoCard(
                                          pharmacy:
                                              pharmaciesState.selectedPharmacy,
                                        )
                                    ],
                                  ))
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
