import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/geocoder_manager.dart';
import 'package:nevis/core/models/map_marker_model.dart';
import 'package:nevis/features/presentation/pages/order/order_delivery/pick_address_field_on_map_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/map/pharmacy_map_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart' as ym;

class PickAddressMapScreen extends StatefulWidget {
  final GeoObject? initialGeoObject;
  const PickAddressMapScreen({super.key, required this.initialGeoObject});

  @override
  State<PickAddressMapScreen> createState() => _PickAddressMapScreenState();
}

class _PickAddressMapScreenState extends State<PickAddressMapScreen> {
  late TextEditingController addressController;
  ym.Point? selectedPoint;
  GeoObject? geoObject;

  @override
  void initState() {
    if (widget.initialGeoObject != null) {
      geoObject = widget.initialGeoObject;
      selectedPoint = ym.Point(
          latitude: geoObject!.point!.latitude!,
          longitude: geoObject!.point!.longitude!);
    }

    addressController = TextEditingController(
        text:
            geoObject?.metaDataProperty?.geocoderMetaData?.address?.formatted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiConstants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: getMarginOrPadding(bottom: 80),
          child: Column(
            children: [
              CustomAppBar(
                title: 'Адрес',
                showBack: true,
                onChangedField: (value) {},
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: getMarginOrPadding(left: 20, right: 20),
                child: PickAddressWithSuggestionsField(
                  addressController: addressController,
                  onPickSuggestionObject: onPickSuggestionObject,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: PharmacyMapWidget(
                    mapType: PharmacyMapType.addressPickup,
                    points: [
                      if (selectedPoint != null)
                        MapMarkerModel(
                            id: 1,
                            point: selectedPoint!,
                            data: {'geoObject': geoObject})
                    ],
                    onMapTap: (point) => onMapTapHandler(point),
                    onUnselectPoint: clearAddress),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future onMapTapHandler(ym.Point point) async {
    final geocoderManager = sl<GeocoderManager>();
    GeocodeResponse? response = await geocoderManager.getGeocodeFromPoint(
        point.latitude, point.longitude);

    if ((response?.comparedObjects ?? []).isNotEmpty) {
      // Update address controllers
      setState(() {
        selectedPoint = point; // Обновляем выбранную точку
        geoObject = response
            ?.response?.geoObjectCollection?.featureMember?.first.geoObject;

        addressController.text =
            geoObject?.metaDataProperty?.geocoderMetaData?.address?.formatted ??
                '';
      });
    }
  }

  Future onPickSuggestionObject(GeoObject? geoObj) async {
    if (geoObject != null) {
      // Update address controllers
      setState(() {
        selectedPoint = ym.Point(
            latitude: geoObj!.point!.point!.lat,
            longitude: geoObj.point!.point!.lon); // Обновляем выбранную точку
        geoObject = geoObj;

        addressController.text =
            geoObject?.metaDataProperty?.geocoderMetaData?.address?.formatted ??
                '';
      });
    }
  }

  clearAddress() {
    setState(() {
      selectedPoint = null;
      geoObject = null;
      addressController.text = '';
    });
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}
