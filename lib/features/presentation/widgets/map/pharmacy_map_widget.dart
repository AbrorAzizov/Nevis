import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/models/map_marker_model.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:nevis/features/data/models/product_pharmacy_model.dart';
import 'package:nevis/features/presentation/bloc/pharmacy_map/pharmacy_map_bloc.dart';
import 'package:nevis/features/presentation/bloc/value_buy_product_screen/value_buy_product_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/favorite_pharmacies_screen/pharmacy_info_card.dart';
import 'package:nevis/features/presentation/widgets/map/map_button.dart';
import 'package:nevis/features/presentation/widgets/value_buy_product_screen/pharmacy_product_info_card_widget.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class PharmacyMapWidget extends StatelessWidget {
  final List<MapMarkerModel> points;
  final PharmacyMapType mapType;
  final double? height;

  const PharmacyMapWidget(
      {super.key,
      required this.points,
      this.height,
      this.mapType = PharmacyMapType.defaultMap});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PharmacyMapBloc()..add(InitPharmacyMapEvent(points: points)),
      child: BlocBuilder<PharmacyMapBloc, PharmacyMapState>(
        builder: (context, state) {
          final bloc = context.read<PharmacyMapBloc>();
          final valueBuyBloc = mapType == PharmacyMapType.valueBuyMap
              ? context.read<ValueBuyProductScreenBloc>()
              : null;
          return ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: getMarginOrPadding(
                left: mapType == PharmacyMapType.valueBuyMap ? 0 : 20,
                right: mapType == PharmacyMapType.valueBuyMap ? 0 : 20,
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  YandexMap(
                    onMapCreated: (controller) => bloc
                        .add(AttachControllerEvent(mapController: controller)),
                    onCameraPositionChanged:
                        (position, reason, isGesture, visibleRegion) {
                      bloc.add(UpdatePharmacyMapEvent(position: position));
                    },
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    mapObjects: state.markers,
                  ),
                  Positioned(
                    right: 8,
                    bottom: 16,
                    left: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MapButton(
                          assetName: Paths.locationIconPath,
                          color: UiConstants.blueColor,
                          backgroundColor: UiConstants.blue4Color,
                          onPressed: () =>
                              bloc.add(MoveToCurrentLocationEvent()),
                        ),
                        SizedBox(height: 8.h),
                        MapButton(
                          assetName: Paths.plusIconPath,
                          color: UiConstants.black2Color,
                          backgroundColor:
                              UiConstants.whiteColor.withOpacity(.8),
                          onPressed: () => bloc.add(ZoomInEvent()),
                        ),
                        SizedBox(height: 4.h),
                        MapButton(
                          assetName: Paths.minusIconPath,
                          color: UiConstants.black2Color,
                          backgroundColor:
                              UiConstants.whiteColor.withOpacity(.8),
                          onPressed: () => bloc.add(ZoomOutEvent()),
                        ),
                        if (state.showStackWindow)
                          Padding(
                            padding: getMarginOrPadding(top: 16),
                            child: Builder(
                              builder: (context) {
                                final selectedPoint = state.points.firstWhere(
                                  (e) =>
                                      e.id.toString() == state.selectedMarkerId,
                                );

                                final pharmacy = ProductPharmacyModel.fromJson(
                                    selectedPoint.data!);

                                if (mapType != PharmacyMapType.valueBuyMap) {
                                  return PharmacyInfoCard(
                                    pharmacyMapType: mapType,
                                    pharmacy: PharmacyModel.fromJson(
                                        selectedPoint.data!),
                                  );
                                }

                                final counter = valueBuyBloc!
                                        .state.counters[pharmacy.pharmacyId] ??
                                    1;

                                return PharmacyProductInfoCard(
                                  pharmacy: pharmacy,
                                  counter: counter,
                                  onCounterChanged: (newCounter) {
                                    valueBuyBloc.add(
                                      UpdateCounterEvent(
                                        pharmacyId: pharmacy.pharmacyId!,
                                        counter: newCounter,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
