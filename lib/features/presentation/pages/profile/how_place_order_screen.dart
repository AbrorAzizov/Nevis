import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/how_place_order_screen/how_place_order_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/add_product_to_cart_block.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/pick_up_order_block.dart';
import 'package:nevis/features/presentation/widgets/how_place_order_screen/select_product_block.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HowPlaceOrderScreen extends StatefulWidget {
  const HowPlaceOrderScreen({super.key});

  @override
  State<HowPlaceOrderScreen> createState() => _HowPlaceOrderScreenState();
}

class _HowPlaceOrderScreenState extends State<HowPlaceOrderScreen> {
  bool isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(Duration(seconds: 5), () {
      _timer.cancel();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => HowPlaceOrderScreenBloc(),
          child: BlocBuilder<HowPlaceOrderScreenBloc, HowPlaceOrderScreenState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    justifyMultiLineText: false,
                    textBoneBorderRadius:
                        TextBoneBorderRadius.fromHeightFactor(.5),
                    enabled: isLoading,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                                showBack: true,
                                title: 'Как сделать заказ?',
                                backgroundColor: UiConstants.backgroundColor),
                            Expanded(
                              child: ListView(
                                padding: getMarginOrPadding(
                                    top: 16, bottom: 94, left: 20, right: 20),
                                shrinkWrap: true,
                                children: [
                                  SelectProductBlock(),
                                  SizedBox(height: 16.h),
                                  AddProductToCartBlock(),
                                  SizedBox(height: 16.h),
                                  PickUpOrderBlock(),
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
