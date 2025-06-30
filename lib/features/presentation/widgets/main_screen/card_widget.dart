import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/main/bonus_cards/activate_bonus_screen.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_phone_call.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF144B63).withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: -4,
            offset: Offset(-1, -4),
          ),
        ],
        borderRadius: BorderRadius.circular(18.r),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(Paths.bonusCardIconPath),
        ),
      ),
      child: Padding(
        padding: getMarginOrPadding(top: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: getMarginOrPadding(left: 20),
              child: Text(
                'ВАША КАРТА — CASHBACK',
                style: UiConstants.textStyle4.copyWith(
                  color: UiConstants.blueColor,
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: getMarginOrPadding(left: 20),
              child: Text(
                'Карта лояльности',
                style: UiConstants.textStyle19.copyWith(
                  color: UiConstants.black2Color,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: getMarginOrPadding(left: 16),
              child: Row(
                children: [
                  SizedBox(
                    height: 44.h,
                    width: 182.w,
                    child: AppButtonWidget(
                        isExpanded: false,
                        onTap: () {
                          String? token = sl<SharedPreferences>()
                              .getString(SharedPreferencesKeys.accessToken);
                          if (token != null) {
                            Navigator.of(context).push(
                              Routes.createRoute(
                                ActivateBonusCardScreen(),
                                settings: RouteSettings(
                                  name: Routes.activateBonusCardScreen,
                                ),
                              ),
                            );
                          } else {
                            Navigator.of(
                                    context.read<HomeScreenBloc>().context!)
                                .push(
                              Routes.createRoute(
                                const LoginScreenWithPhoneCall(
                                  canBack: true,
                                ),
                                settings: RouteSettings(
                                  name: Routes.loginScreenPhoneCall,
                                  arguments: {
                                    'redirect_type': LoginScreenType.login
                                  },
                                ),
                              ),
                            );
                          }
                        },
                        text: 'Активировать карту'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
