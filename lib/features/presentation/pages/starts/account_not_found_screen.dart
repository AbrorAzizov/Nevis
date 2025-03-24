import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';

class AccountNotFoundScreen extends StatelessWidget {
  const AccountNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: UiConstants.whiteColor,
          surfaceTintColor: Colors.transparent),
      body: Column(
        children: [
          Container(
            padding:
                getMarginOrPadding(left: 20, right: 20, bottom: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    Paths.arrowBackIconPath,
                    width: 24.w,
                    height: 24.w,
                    color: UiConstants.darkBlueColor.withOpacity(.4),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'По данному номеру телефона не найдено аккаунта',
                  style: UiConstants.textStyle1
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Зарегистрируйтесь, чтобы совершать покупки и пользоваться нашей бонусной системой',
                  style: UiConstants.textStyle2
                      .copyWith(color: UiConstants.darkBlueColor),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: getMarginOrPadding(right: 20, left: 20, bottom: 32),
              decoration: BoxDecoration(
                color: UiConstants.whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Paths.noFoundAccountIconPath,
                      width: MediaQuery.of(context).size.width),
                  Spacer(),
                  // AppButtonWidget(
                  //   isActive: true,
                  //   text: 'Зарегистироваться',
                  //   onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  //     Routes.createRoute(
                  //       const SignUpScreen(),
                  //       settings: RouteSettings(
                  //         name: Routes.signUpScreen,
                  //         arguments: {
                  //           'redirect_type': CodeScreenType.signUp,
                  //           'phone': args!['phone'],
                  //         },
                  //       ),
                  //     ),
                  //     (route) {
                  //       return route.settings.name == "/login_screen" &&
                  //           (route.settings.arguments as Map<String,
                  //                   dynamic>?)?['redirect_type'] ==
                  //               LoginScreenType.login;
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
