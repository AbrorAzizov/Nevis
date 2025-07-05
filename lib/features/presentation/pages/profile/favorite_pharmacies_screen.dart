import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:nevis/features/presentation/bloc/favorite_pharmacies_screen/favorite_pharmacies_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/favorite_pharmacies_screen/pharmacy_card.dart';
import 'package:nevis/features/presentation/widgets/favorite_pharmacies_screen/pharmacy_info_card.dart';
import 'package:nevis/features/presentation/widgets/map/pharmacy_map_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritePharmaciesScreen extends StatefulWidget {
  const FavoritePharmaciesScreen({super.key});

  @override
  State<FavoritePharmaciesScreen> createState() =>
      _FavoritePharmaciesScreenState();
}

class _FavoritePharmaciesScreenState extends State<FavoritePharmaciesScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<FavoritePharmaciesBloc>().add(ResetSearchEvent());
    return BlocBuilder<FavoritePharmaciesBloc, FavoritePharmaciesState>(
      builder: (context, state) {
        final bloc = context.read<FavoritePharmaciesBloc>();
        final isSearching = state.findPharmaciesPressed;

        return Scaffold(
          backgroundColor: UiConstants.whiteColor,
          body: SafeArea(
            child: Padding(
              padding: getMarginOrPadding(bottom: 87),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: 'Аптеки',
                    hintText: isSearching ? 'Поиск аптек' : null,
                    controller: searchController,
                    showBack: true,
                    isShowFavoriteButton: false,
                    onTapCancel: () {
                      searchController.clear();
                      bloc.add(ChangeQueryEvent(""));
                    },
                    onChangedField: (value) {
                      bloc.add(ChangeQueryEvent(value));
                    },
                  ),
                  if (!isSearching && state.favoritePharmacies.isNotEmpty)
                    Padding(
                      padding: getMarginOrPadding(left: 20, right: 20),
                      child: BlocProvider(
                        create: (_) =>
                            SelectorCubit(index: state.selectorIndex),
                        child: Selector(
                          titlesList: const ['Карта', 'Список'],
                          onTap: (int index) {
                            bloc.add(ChangeSelectorIndexEvent(index));
                          },
                        ),
                      ),
                    ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: Skeletonizer(
                      enabled: state.isLoading,
                      ignorePointers: false,
                      child: Builder(
                        builder: (context) {
                          if (isSearching) {
                            if (state.pharmacies.isNotEmpty) {
                              return PharmacyMapWidget(
                                points: state.pharmacyPoints,
                                selectedMarkerBuilder: (context, point, bloc) {
                                  return PharmacyInfoCard(
                                    pharmacyMapType: PharmacyMapType.defaultMap,
                                    pharmacy:
                                        PharmacyModel.fromJson(point.data!),
                                  );
                                },
                              );
                            } else {
                              return _buildEmptyState(
                                context,
                                title: 'Аптеки не найдены',
                                buttonText: 'Сбросить поиск',
                                onTap: () {
                                  searchController.clear();
                                  bloc.add(ChangeQueryEvent(""));
                                },
                              );
                            }
                          }

                          if (state.favoritePharmacies.isNotEmpty) {
                            return state.selectorIndex != 0
                                ? ListView.separated(
                                    padding: getMarginOrPadding(
                                        bottom: 94, left: 20, right: 20),
                                    itemCount: state.favoritePharmacies.length,
                                    itemBuilder: (context, index) =>
                                        PharmacyCard(
                                      pharmacy: state.favoritePharmacies[index],
                                      mapType:
                                          PharmacyMapType.favrotiePharmaciesMap,
                                      onTap: () {},
                                    ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 8.h),
                                  )
                                : PharmacyMapWidget(
                                    points: state.favoritePoints,
                                    selectedMarkerBuilder:
                                        (context, point, bloc) {
                                      return PharmacyInfoCard(
                                        pharmacyMapType:
                                            PharmacyMapType.defaultMap,
                                        pharmacy:
                                            PharmacyModel.fromJson(point.data!),
                                      );
                                    },
                                  );
                          }

                          return _buildEmptyState(
                            context,
                            title: 'Нет любимых аптек',
                            buttonText: 'Найти аптеку на карте',
                            onTap: () {
                              bloc.add(ShowPharmaciesEvent());
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(
    BuildContext context, {
    required String title,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: getMarginOrPadding(left: 20, right: 20),
          child: Row(
            children: [
              Text(
                title,
                style: UiConstants.textStyle20,
              ),
            ],
          ),
        ),
        Image.asset(
          Paths.noPharmaciesIconPath,
          width: 211,
          height: 211,
        ),
        Padding(
          padding: getMarginOrPadding(left: 20, right: 20),
          child: AppButtonWidget(
            text: buttonText,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
