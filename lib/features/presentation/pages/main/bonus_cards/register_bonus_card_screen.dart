import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/register_bonus_card_screen/register_bonus_cardscreen_bloc.dart';
import 'package:nevis/features/presentation/pages/main/bonus_cards/bonus_card_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/bonus_program_text_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/register_bonus_card_screen/general_information_block_bonus_card.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../widgets/register_bonus_card_screen/checkboxed_block_bonus_card.dart';

class RegisterBonusCardScreen extends StatelessWidget {
  final BonusCardType cardType;
  const RegisterBonusCardScreen({super.key, required this.cardType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, homeState) {
      final homeBloc = context.read<HomeScreenBloc>();
      return BlocProvider(
        create: (context) => RegisterBonusCardScreenBloc(
            context: context.read<HomeScreenBloc>().context,
            getMeUC: sl(),
            cardType: cardType)
          ..getProfile(),
        child: BlocBuilder<RegisterBonusCardScreenBloc,
            RegisterBonusCardScreenState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: UiConstants.backgroundColor,
              body: SafeArea(
                child: Skeletonizer(
                  ignorePointers: false,
                  enabled: state.isLoading,
                  child: Builder(
                    builder: (context) {
                      return Column(
                        children: [
                          CustomAppBar(
                            title: cardType == BonusCardType.physical
                                ? 'Регистрация  карты'
                                : 'Выпуск виртуальной карты',
                            showBack: true,
                          ),
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              padding: getMarginOrPadding(
                                  bottom: 94, top: 16, right: 20, left: 20),
                              children: [
                                cardType == BonusCardType.physical
                                    ? Container(
                                        width: 320.w,
                                        height: 180.h,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(
                                                    0x19144B63), // #144B63 с 10% прозрачности
                                                offset:
                                                    Offset(-1, 4), // Смещение
                                                blurRadius: 50, // Размытие
                                                spreadRadius:
                                                    -4, // Распространение
                                              ),
                                            ],
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(Paths
                                                    .bonusCardInstructionIconPath))),
                                      )
                                    : Container(
                                        width: 320.w,
                                        height: 180.h,
                                        decoration: BoxDecoration(
                                            boxShadow: [],
                                            borderRadius:
                                                BorderRadius.circular(18.r),
                                            image: DecorationImage(
                                                fit: BoxFit.fitHeight,
                                                image: AssetImage(Paths
                                                    .virtualBonusCardIconPath))),
                                        child: Padding(
                                          padding: getMarginOrPadding(
                                            bottom: 10,
                                            top: 20,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: getMarginOrPadding(
                                                    left: 20),
                                                child: ShaderMask(
                                                  shaderCallback: (bounds) =>
                                                      LinearGradient(
                                                    colors: [
                                                      Color(0xFFBF80FF),
                                                      Color(0xFF85C6FF),
                                                    ],
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                  ).createShader(bounds),
                                                  child: Text(
                                                    'ВИРТУАЛЬНАЯ КАРТА ЛОЯЛЬНОСТИ',
                                                    style: UiConstants
                                                        .textStyle4
                                                        .copyWith(
                                                            height: 1,
                                                            color: UiConstants
                                                                .whiteColor,
                                                            letterSpacing: 0),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Padding(
                                                padding: getMarginOrPadding(
                                                    left: 20),
                                                child: Text(
                                                  'Ваши бонусы\nвсегда под рукой.',
                                                  style: UiConstants.textStyle3
                                                      .copyWith(
                                                    color:
                                                        UiConstants.black2Color,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                cardType == BonusCardType.physical
                                    ? Padding(
                                        padding: getMarginOrPadding(bottom: 16),
                                        child: Text(
                                          'Номер карты состоит из 13 цифр, которые находятся под штрих-кодом, на оборотной стороне карты',
                                          style: UiConstants.textStyle3
                                              .copyWith(
                                                  color: UiConstants.black3Color
                                                      .withOpacity(.6)),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                GeneralInformationBlock(
                                  screenContext: context,
                                  cardType: cardType,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                CheckboxesBlock(
                                  screenContext: context,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                AppButtonWidget(
                                  isActive: state.isButtonActive,
                                  text: cardType == BonusCardType.physical
                                      ? 'Зарегистрировать карту'
                                      : 'Получить виртуальную карту',
                                  onTap: () {
                                    // context
                                    //     .read<
                                    //         RegisterBonusCardScreenBloc>()
                                    //     .add(
                                    //       SubmitEvent(),
                                    //     );
                                    Navigator.of(context).push(
                                      Routes.createRoute(
                                        BonusCardScreen(),
                                        settings: RouteSettings(
                                          name: Routes.bonusCardScreen,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                BonusProgramTextWidget()
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
