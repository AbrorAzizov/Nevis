import 'package:collection/collection.dart';
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
import 'package:nevis/features/presentation/widgets/favorite_pharmacies_screen/address_card.dart';
import 'package:nevis/features/presentation/widgets/favorite_pharmacies_screen/pharmacy_info_card.dart';
import 'package:nevis/features/presentation/widgets/map/map_button.dart';
import 'package:nevis/features/presentation/widgets/value_buy_product_screen/pharmacy_product_info_card_widget.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class PharmacyMapWidget extends StatefulWidget {
  final List<MapMarkerModel> points;
  final PharmacyMapType mapType;
  final double? height;
  final Function(Point point)? onMapTap;
  final Function()? onUnselectPoint;

  const PharmacyMapWidget({
    super.key,
    required this.points,
    this.height,
    this.mapType = PharmacyMapType.defaultMap,
    this.onMapTap,
    this.onUnselectPoint,
  });

  @override
  State<PharmacyMapWidget> createState() => _PharmacyMapWidgetState();
}

class _PharmacyMapWidgetState extends State<PharmacyMapWidget> {
  late final PharmacyMapBloc _bloc;

  @override
  void initState() {
    super.initState();
    final initPoint = widget.mapType == PharmacyMapType.addressPickup &&
            widget.points.isNotEmpty
        ? widget.points.first.point
        : null;

    _bloc = PharmacyMapBloc()
      ..add(InitPharmacyMapEvent(
          points: widget.points,
          mapType: widget.mapType,
          initPoint: initPoint));

    if (widget.points.isNotEmpty &&
        widget.mapType == PharmacyMapType.addressPickup) {
      _bloc.add(SelectMarkerEvent(markerId: widget.points.first.id.toString()));
    }
  }

  @override
  void didUpdateWidget(covariant PharmacyMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.points != oldWidget.points) {
      if (widget.points.isNotEmpty &&
          widget.mapType == PharmacyMapType.addressPickup) {
        if (_bloc.state.selectedMarkerId == null ||
            !_bloc.state.showStackWindow) {
          _bloc.add(
              SelectMarkerEvent(markerId: widget.points.first.id.toString()));
        }
        _bloc.add(MoveToPointEvent(point: widget.points.first.point));
      }
      _bloc.add(UpdatePharmacyMapMarkersEvent(points: widget.points));
    }
  }

  @override
  void dispose() {
    _bloc.add(ClosePharmacyMapEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final valueBuyBloc = widget.mapType == PharmacyMapType.valueBuyMap
        ? context.read<ValueBuyProductScreenBloc>()
        : null;

    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<PharmacyMapBloc, PharmacyMapState>(
        builder: (context, state) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: getMarginOrPadding(
                left: widget.mapType == PharmacyMapType.valueBuyMap ? 0 : 20,
                right: widget.mapType == PharmacyMapType.valueBuyMap ? 0 : 20,
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  YandexMap(
                      onMapCreated: (controller) => _bloc.add(
                          AttachControllerEvent(mapController: controller)),
                      onCameraPositionChanged:
                          (position, reason, isGesture, visibleRegion) {
                        _bloc.add(UpdatePharmacyMapEvent(position: position));
                      },
                      gestureRecognizers: <Factory<
                          OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                      onMapTap: widget.onMapTap,
                      mapObjects: state.markers),
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
                              _bloc.add(MoveToCurrentLocationEvent()),
                        ),
                        SizedBox(height: 8.h),
                        MapButton(
                          assetName: Paths.plusIconPath,
                          color: UiConstants.black2Color,
                          backgroundColor:
                              UiConstants.whiteColor.withOpacity(.8),
                          onPressed: () => _bloc.add(ZoomInEvent()),
                        ),
                        SizedBox(height: 4.h),
                        MapButton(
                          assetName: Paths.minusIconPath,
                          color: UiConstants.black2Color,
                          backgroundColor:
                              UiConstants.whiteColor.withOpacity(.8),
                          onPressed: () => _bloc.add(ZoomOutEvent()),
                        ),
                        if (state.showStackWindow)
                          Padding(
                            padding: getMarginOrPadding(top: 16),
                            child: Builder(
                              builder: (context) {
                                final selectedPoint = state.points
                                    .firstWhereOrNull((e) =>
                                        e.id.toString() ==
                                        state.selectedMarkerId);

                                if (selectedPoint == null) return SizedBox();

                                if (widget.mapType ==
                                    PharmacyMapType.addressPickup) {
                                  return AddressCard(
                                    geoObject: selectedPoint.data?['geoObject'],
                                    onUnselectPoint: () {
                                      _bloc.add(
                                          SelectMarkerEvent(markerId: null));
                                      widget.onUnselectPoint?.call();
                                    },
                                  );
                                }

                                final pharmacy = ProductPharmacyModel.fromJson(
                                    selectedPoint.data!);

                                if (widget.mapType !=
                                    PharmacyMapType.valueBuyMap) {
                                  return PharmacyInfoCard(
                                    pharmacyMapType: widget.mapType,
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
