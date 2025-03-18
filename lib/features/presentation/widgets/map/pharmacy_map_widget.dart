import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/models/map_marker_model.dart';
import 'package:nevis/features/presentation/bloc/pharmacy_map/pharmacy_map_bloc.dart';
import 'package:nevis/features/presentation/widgets/favourite_pharmacies_screen/pharmacy_info_card.dart';
import 'package:nevis/features/presentation/widgets/map/map_button.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class PharmacyMapWidget extends StatelessWidget {
  final List<MapMarkerModel> points;
  final double? height;
  const PharmacyMapWidget({super.key, required this.points, this.height});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PharmacyMapBloc()..add(InitPharmacyMapEvent(points: points)),
      child: BlocBuilder<PharmacyMapBloc, PharmacyMapState>(
        builder: (context, state) {
          final bloc = context.read<PharmacyMapBloc>();

          return ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: getMarginOrPadding(bottom: 94, left: 20, right: 20),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  YandexMap(
                      onMapCreated: (controller) => bloc
                        ..add(AttachControllerEvent(mapController: controller)),
                      onCameraPositionChanged: (position, reason, isGesture,
                              visibleRegion) =>
                          bloc.add(UpdatePharmacyMapEvent(position: position)),
                      gestureRecognizers: <Factory<
                          OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                      mapObjects: state.markers),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    left: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MapButton(
                            assetName: Paths.locationIconPath,
                            color: UiConstants.blueColor,
                            backgroundColor: UiConstants.blue4Color,
                            onPressed: () =>
                                bloc.add(MoveToCurrentLocationEvent())),
                        SizedBox(height: 8.h),
                        MapButton(
                            assetName: Paths.plusIconPath,
                            color: UiConstants.black2Color,
                            backgroundColor:
                                UiConstants.whiteColor.withOpacity(.8),
                            onPressed: () => bloc.add(ZoomInEvent())),
                        SizedBox(height: 4.h),
                        MapButton(
                            assetName: Paths.minusIconPath,
                            color: UiConstants.black2Color,
                            backgroundColor:
                                UiConstants.whiteColor.withOpacity(.8),
                            onPressed: () => bloc.add(ZoomOutEvent())),
                        if (state.showStackWindow)
                          Padding(
                            padding: getMarginOrPadding(top: 16),
                            child: Builder(builder: (context) {
                              /*final String address = state.points
                                      .firstWhereOrNull((e) =>
                                          e.id.toString() == state.selectedMarkerId)
                                      ?.data?['address'] ??
                                  '';
              
                              final List<String> addressSplit = address.split(', ');
              
                              String city = '';
                              String street = '';
              
                              if (addressSplit.length > 1) {
                                city = addressSplit.first;
                                street = addressSplit.skip(1).join(', ');
                              }*/

                              return PharmacyInfoCard();
                            }),
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
