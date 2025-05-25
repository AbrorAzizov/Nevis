import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/sales_screen/sales_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/sales_screen/sales_categories_list.dart';
import 'package:nevis/features/presentation/widgets/sales_screen/sales_list_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
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
          create: (context) => SalesScreenBloc(),
          child: BlocBuilder<SalesScreenBloc, SalesScreenState>(
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
                                title: 'Акции и скидки',
                                backgroundColor: UiConstants.backgroundColor),
                            Expanded(
                              child: ListView(
                                padding:
                                    getMarginOrPadding(top: 16, bottom: 94),
                                shrinkWrap: true,
                                children: [
                                  SalesCategoriesList(),
                                  SizedBox(height: 16.h),
                                  ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: getMarginOrPadding(
                                          right: 20, left: 20),
                                      itemBuilder: (context, index) =>
                                          SalesListItem(isExpanded: false),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 16.h),
                                      itemCount: 7)
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
