import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/map/address_plate.dart';
import 'package:nevis/features/presentation/widgets/map/map_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';



class MapWidget extends StatelessWidget {
  final List<MapObject<dynamic>> mapObjects;
  const MapWidget({super.key, required this.mapObjects});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        
        SizedBox(
          height: 542.h,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: YandexMap(
                onMapCreated: (controller) {
                  controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: Point(latitude: 59.938784, longitude: 30.314997),
                          zoom: 12),
                    ),
                  );
                },
                onCameraPositionChanged:
                    (position, reason, isGesture) {

                    },
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
                mapObjects: mapObjects),
          ),
        ),
        Positioned(
          right: 8,
          bottom: 200,
          left: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MapButton(
                  assetName: Paths.locationIconPath,
                  color: UiConstants.pink2Color,
                  onPressed: () {}),
              SizedBox(height: 16.h),
              MapButton(
                  assetName: Paths.plusIconPath,
                  color: Color(0xFF222222).withOpacity(.6),
                  onPressed: () {}),
              SizedBox(height: 4.h),
              MapButton(
                  assetName: Paths.minusIconPath,
                  color: Color(0xFF222222).withOpacity(.6),
                  onPressed: () {}),
              SizedBox(height: 16.h),
             
            ],
          ),
        ),
      ],
    );
  }
}
