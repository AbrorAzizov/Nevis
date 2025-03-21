import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';

class PriceRangeWidget extends StatefulWidget {
  const PriceRangeWidget({super.key});

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

  double minAllowedPrice = 0;
  double maxAllowedPrice = 1000;
  double minSelectedPrice = 0;
  double maxSelectedPrice = 1000;

  final minPriceController = TextEditingController(text: '0');
  final maxPriceController = TextEditingController(text: '1000');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Цена',
          style: UiConstants.textStyle3.copyWith(
              color: UiConstants.darkBlueColor, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AppTextFieldWidget(
                  fillColor: UiConstants.whiteColor,
                  controller: minPriceController,
                  onChangedField: (value) {
                    setState(() {
                      minPriceController.text = value;
                      minSelectedPrice = double.parse(value);
                    });
                    //searchBloc.add(
                    //  ChangePriceEvent(double.tryParse(value), true),
                    //);
                  },
                  boxShadow: boxShadow),
            ),
            Container(
              margin: getMarginOrPadding(right: 8, left: 8),
              height: 1.h,
              width: 12.w,
              color: Color(0xFF222222).withOpacity(.6),
            ),
            Expanded(
              child: AppTextFieldWidget(
                  fillColor: UiConstants.whiteColor,
                  controller: maxPriceController,
                  onChangedField: (value) {
                    setState(() {
                      maxSelectedPrice = double.parse(value);
                    });
                    //searchBloc.add(
                    //  ChangePriceEvent(double.tryParse(value), false),
                    //);
                  },
                  boxShadow: boxShadow),
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
            values: RangeValues(minSelectedPrice, maxSelectedPrice),
            min: minAllowedPrice,
            max: maxAllowedPrice,
            activeColor: UiConstants.blueColor,
            inactiveColor: UiConstants.white5Color,
            onChanged: (RangeValues values) => setState(() {
              minSelectedPrice = values.start;
              minPriceController.text = values.start.toStringAsFixed(0);
              maxSelectedPrice = values.end;
              maxPriceController.text = values.end.toStringAsFixed(0);
            }),
            labels: RangeLabels(
              minSelectedPrice.round().toString(),
              maxSelectedPrice.round().toString(),
            ),
          ),
        ),
      ],
    );
  }
}
