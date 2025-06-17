import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/bonus_card_screen/bonus_card_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/qr_code_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BonusCardScreen extends StatelessWidget {
  const BonusCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final BonusCardType? loyalCardType = args?['loyal_card_type'];

    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, homeState) {
      return BlocProvider(
        create: (context) =>
            BonusCardScreenBloc(getQRCodeUC: sl())..add(LoadDataEvent()),
        child: BlocBuilder<BonusCardScreenBloc, BonusCardScreenState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: UiConstants.backgroundColor,
              body: SafeArea(
                child: Skeletonizer(
                  enabled: state.isLoading,
                  child: Builder(
                    builder: (context) {
                      return Column(
                        children: [
                          CustomAppBar(
                            title: 'Карта лояльности',
                            showBack: true,
                          ),
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              padding: getMarginOrPadding(
                                  bottom: 94, top: 16, right: 20, left: 20),
                              children: [
                                QrCodeWidget(
                                    loyaltyCardQREntity: state.loyalCard!),
                                SizedBox(height: 16.h),
                                Container(
                                  height: 57.h,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF144B63)
                                              .withOpacity(0.1),
                                          blurRadius: 50,
                                          spreadRadius: -4,
                                          offset: Offset(-1, -4),
                                        ),
                                      ],
                                      color: UiConstants.whiteColor,
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: getMarginOrPadding(all: 12),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(Paths.cardIconPath),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Тип',
                                              style: UiConstants.textStyle15,
                                            ),
                                            Expanded(
                                              child: Text(
                                                loyalCardType ==
                                                        BonusCardType.virtual
                                                    ? 'Виртуальная'
                                                    : 'Физическая',
                                                style: UiConstants.textStyle2
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Text(
                                  'Мы рады приветствовать вас в нашей программе постоянного клиента! Наши персонализированные скидки и специальные предложения помогут вам экономить на покупках, а наша команда аптечных специалистов всегда готова предложить индивидуальные рекомендации и профессиональную помощь.',
                                  style: UiConstants.textStyle3.copyWith(
                                      color: UiConstants.black3Color
                                          .withOpacity(.6)),
                                )
                              ],
                            ),
                          )
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
    });
  }
}
