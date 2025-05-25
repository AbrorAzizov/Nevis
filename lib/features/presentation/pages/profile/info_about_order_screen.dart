import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/info_about_order_screen/info_about_order_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_plate_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/info_about_order_screen/cost_courier_delivery_block.dart';
import 'package:nevis/features/presentation/widgets/info_about_order_screen/courier_delivery_terms_block.dart';
import 'package:nevis/features/presentation/widgets/info_about_order_screen/courier_delivery_time_block.dart';
import 'package:nevis/features/presentation/widgets/info_about_order_screen/courier_delivery_zones_block.dart';
import 'package:nevis/features/presentation/widgets/info_about_order_screen/orders_with_delivery_accepted_block.dart';
import 'package:nevis/features/presentation/widgets/info_about_order_screen/types_delivery_block.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InfoAboutOrderScreen extends StatefulWidget {
  const InfoAboutOrderScreen({super.key});

  @override
  State<InfoAboutOrderScreen> createState() => _InfoAboutOrderScreenState();
}

class _InfoAboutOrderScreenState extends State<InfoAboutOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => InfoAboutOrderScreenBloc(getPharmaciesUC: sl())
            ..add(LoadDataEvent()),
          child:
              BlocBuilder<InfoAboutOrderScreenBloc, InfoAboutOrderScreenState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    justifyMultiLineText: false,
                    textBoneBorderRadius:
                        TextBoneBorderRadius.fromHeightFactor(.5),
                    enabled: false,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                                showBack: true,
                                title: 'Информация о получении заказа',
                                backgroundColor: UiConstants.backgroundColor),
                            Expanded(
                              child: ListView(
                                padding: getMarginOrPadding(
                                    top: 16, bottom: 94, left: 20, right: 20),
                                shrinkWrap: true,
                                children: [
                                  InfoPlateWidget(
                                      text:
                                          'Доставка производится только по Минску и Минскому району'),
                                  SizedBox(height: 16.h),
                                  TypesDeliveryBlock(),
                                  SizedBox(height: 16.h),
                                  CostCourierDeliveryBlock(),
                                  SizedBox(height: 16.h),
                                  CourierDeliveryTimeBlock(),
                                  SizedBox(height: 16.h),
                                  OrdersWithDeliveryAcceptedBlock(),
                                  SizedBox(height: 16.h),
                                  CourierDeliveryTermsBlock(),
                                  SizedBox(height: 16.h),
                                  CourierDeliveryZonesBlock(),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
