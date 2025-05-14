import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/about_us_screen/about_us_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/book_comments_block.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/gosfarmnadzor_block.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/legal_address_block.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/online_pharm_block.dart';
import 'package:nevis/features/presentation/widgets/about_us_screen/social_network_block.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
          create: (context) => AboutUsScreenBloc(),
          child: BlocBuilder<AboutUsScreenBloc, AboutUsScreenState>(
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
                                title: 'Информация о нас',
                                backgroundColor: UiConstants.backgroundColor),
                            Expanded(
                              child: ListView(
                                padding: getMarginOrPadding(
                                    top: 16, bottom: 94, left: 20, right: 20),
                                shrinkWrap: true,
                                children: [
                                  OnlinePharmBlock(),
                                  SizedBox(height: 16.h),
                                  LegalAddressBlock(),
                                  SizedBox(height: 16.h),
                                  GosfarmnadzorBlock(),
                                  SizedBox(height: 16.h),
                                  SocialNetworkBlock(),
                                  SizedBox(height: 16.h),
                                  BookCommentsBlock(),
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
