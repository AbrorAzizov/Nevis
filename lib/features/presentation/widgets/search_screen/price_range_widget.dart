import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';

class PriceRangeWidget extends StatefulWidget {
  const PriceRangeWidget({super.key, });



  @override
  State<PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {
  List<BoxShadow> boxShadow = [
    BoxShadow(
        offset: Offset(-1, 4),
        color: Color(0xFF00A0E3).withOpacity(.1),
        blurRadius: 10.r,
        spreadRadius: -4.r),
  ];

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SearchScreenBloc, SearchScreenState>(

      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Цена',
              style: UiConstants.textStyle3.copyWith(
                  color: UiConstants.darkBlueColor,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              
                Container(
                  margin: getMarginOrPadding(right: 8, left: 8),
                  height: 1.h,
                  width: 12.w,
                  color: Color(0xFF222222).withOpacity(.6),
                ),
               
              ],
            ),
            SizedBox(height: 3.h),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2.h,
                overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 6.r, disabledThumbRadius: 6.r),
              ),
              child: RangeSlider(
                values:
                    RangeValues(state.minSelectedPrice, state.maxSelectedPrice),
                min: state.minAllowedPrice,
                max: state.maxAllowedPrice,
                activeColor: UiConstants.blueColor,
                inactiveColor: UiConstants.white5Color,
                onChanged: (RangeValues values) {
                
                },
                labels: RangeLabels(
                  state.minSelectedPrice.round().toString(),
                  state.maxSelectedPrice.round().toString(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
