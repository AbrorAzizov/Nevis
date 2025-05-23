import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/favorite_pharmacies_screen/favorite_pharmacies_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/map/pharmacy_map_widget.dart';
import 'package:nevis/locator_service.dart';
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
    return BlocProvider(
      create: (context) => FavoritePharmaciesBloc(getFavoritePharmaciesUC: sl())
        ..add(LoadDataEvent()),
      child: BlocBuilder<FavoritePharmaciesBloc, FavoritePharmaciesState>(
        builder: (context, state) {
          final bloc = context.read<FavoritePharmaciesBloc>();
          return Scaffold(
            backgroundColor: UiConstants.whiteColor,
            body: SafeArea(
              child: Skeletonizer(
                ignorePointers: false,
                enabled: state.isLoading,
                child: Padding(
                  padding: getMarginOrPadding(bottom: 87),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.pharmacies.isNotEmpty
                          ? [
                              CustomAppBar(
                                hintText: 'Поиск аптек',
                                controller: searchController,
                                title: 'Аптеки',
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
                              Padding(
                                padding:
                                    getMarginOrPadding(left: 20, right: 20),
                                child: BlocProvider(
                                  create: (context) =>
                                      SelectorCubit(index: state.selectorIndex),
                                  child: Selector(
                                    titlesList: const ['Карта', 'Список'],
                                    onTap: (int index) => bloc
                                        .add(ChangeSelectorIndexEvent(index)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Expanded(
                                child: state.selectorIndex != 0
                                    ? ListView.separated(
                                        padding: getMarginOrPadding(
                                            bottom: 94, left: 20, right: 20),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            SizedBox(),
                                        // PharmacyCard(),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 8.h),
                                        itemCount: state.pharmacies.length,
                                      )
                                    : PharmacyMapWidget(points: state.points),
                              )
                            ]
                          : [
                              CustomAppBar(
                                title: 'Аптеки',
                                showBack: true,
                                isShowFavoriteButton: false,
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: getMarginOrPadding(
                                          left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Нет любимых аптек',
                                            style: UiConstants.textStyle20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.asset(Paths.noPharmaciesIconPath,
                                        width: 211, height: 211),
                                    Padding(
                                      padding: getMarginOrPadding(
                                          left: 20, right: 20),
                                      child: AppButtonWidget(
                                        text: 'Найти аптеку на карте',
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
