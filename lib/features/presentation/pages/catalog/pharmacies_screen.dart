import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/presentation/bloc/pharmacies_screen/pharmacies_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/cart_pharmacy_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/map/pharmacy_map_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PharmaciesScreen extends StatelessWidget {
  const PharmaciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductPharmacyEntity> pharmacies = ModalRoute.of(context)!
        .settings
        .arguments as List<ProductPharmacyEntity>;

    return BlocProvider(
        create: (context) => PharmaciesScreenBloc()
          ..add(
            LoadDataEvent(pharmacies),
          ),
        child: BlocBuilder<PharmaciesScreenBloc, PharmaciesScreenState>(
            builder: (context, pharmaciesState) {
          PharmaciesScreenBloc pharmaciesBloc =
              context.read<PharmaciesScreenBloc>();

          List<ProductPharmacyEntity> pharmacies =
              (pharmaciesState.pharmacies ?? []);

          pharmacies = pharmacies.where((e) {
            final sortType = pharmaciesState.pharmacySortType;
            final query = (pharmaciesState.query ?? '').toLowerCase();
            final pharmacyName = (e.pharmacyName ?? '').toLowerCase();
            final isMatchingQuery = pharmacyName.contains(query);

            final isMatchingSortType = sortType == TypeReceiving.all ||
                e.pharmacyDelivery ==
                    (sortType == TypeReceiving.delivery
                        ? 'Доставка'
                        : 'Самовывоз');

            return isMatchingSortType && isMatchingQuery;
          }).toList();

          return BlocProvider(
            create: (context) =>
                SelectorCubit(index: pharmaciesState.selectorIndex!),
            child: Scaffold(
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
                            hintText: 'Искать аптеки',
                            controller: pharmaciesBloc.queryController,
                            title: 'Аптеки',
                            showBack: true,
                            action: Text(
                              '${pharmacies.length} аптек${pharmacies.length % 10 == 1 && pharmacies.length % 100 != 11 ? 'a' : ''}',
                              style: UiConstants.textStyle3.copyWith(
                                color:
                                    UiConstants.darkBlue2Color.withOpacity(.6),
                              ),
                            ),
                            isShowFavoriteButton: true,
                            onChangedField: (value) => pharmaciesBloc.add(
                              ChangeQueryEvent(value),
                            ),
                          ),
                          Expanded(
                            child: pharmacies.isEmpty
                                ? Center(
                                    child: Text(
                                      'По выбранным фильтрам аптек нет',
                                      style: UiConstants.textStyle3.copyWith(
                                          color: UiConstants.darkBlueColor,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  )
                                : ListView(
                                    shrinkWrap: true,
                                    padding: getMarginOrPadding(
                                        bottom: 94,
                                        right: 20,
                                        left: 20,
                                        top: 16),
                                    children: [
                                      Selector(
                                        titlesList: const ['Список', 'Карта'],
                                        onTap: (int index) =>
                                            pharmaciesBloc.add(
                                          ChangeSelectorIndexEvent(index),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      if (pharmaciesState.selectorIndex == 0)
                                        ListView.separated(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) =>
                                                CartPharmacyWidget(
                                                    pharmacy: pharmacies[index],
                                                    pharmacyListScreenType:
                                                        PharmacyListScreenType
                                                            .product),
                                            separatorBuilder:
                                                (context, index) =>
                                                    SizedBox(height: 8.h),
                                            itemCount: pharmacies.length)
                                      else
                                        Expanded(
                                          child: PharmacyMapWidget(
                                            points: [],
                                          ),
                                        ),
                                    ],
                                  ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
