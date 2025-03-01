import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/passwrod_screen/password_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_phone_call.dart';
import 'package:nevis/features/presentation/pages/starts/select_region_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/app_template.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/locator_service.dart';


class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    CodeScreenType passwordScreenType = args!['redirect_type'];

    return BlocProvider(
      create: (context) => PasswordScreenBloc(
          phone: args['phone'],
          code: args['code'],
          updatePasswordUC: sl(),
          registrationUC: sl(),
          loginUC: sl(),
          passwordScreenType: passwordScreenType),
      child: BlocConsumer<PasswordScreenBloc, PasswordScreenState>(
        listener: (context, state) {
          if (state is NavigateHomeState) {
            Navigator.of(context).pushAndRemoveUntil(
                Routes.createRoute(
                  const SelectRegionScreen(
                      selectRegionScreenType: SelectRegionScreenType.signUp),
                ),
                (route) => route.isFirst);
          } else if (state is NavigateLoginState) {
            Navigator.of(context).pushAndRemoveUntil(
                Routes.createRoute(
                  const LoginScreenWithPhoneCall(),
                ),
                (route) => route.isFirst);
          }
        },
        builder: (context, state) {
          final bloc = context.read<PasswordScreenBloc>();

          return AppTemplate(
            canBack: true,
            title: passwordScreenType == CodeScreenType.signUp
                ? 'Придумайте пароль'
                : 'Восстановление пароля',
            subTitleText: passwordScreenType == CodeScreenType.reset
                ? 'Придумайте новый пароль:'
                : null,
            bodyPadding:
                getMarginOrPadding(left: 20, right: 20, top: 16, bottom: 24),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextFieldWidget(
                    title: 'Пароль',
                    hintText: 'Введите пароль',
                    isObscuredText: true,
                    controller: bloc.password1Controller,
                    errorText: state.passwordErrorText),
                SizedBox(height: 24.h),
                AppTextFieldWidget(
                    title: 'Повторите пароль',
                    hintText: 'Введите пароль',
                    isObscuredText: true,
                    controller: bloc.password2Controller,
                    errorText: state.passwordErrorText),
                SizedBox(height: 32.h),
                AppButtonWidget(
                  isActive: state.isButtonActive,
                  text: 'Подтвердить',
                  onTap: () => bloc.add(SubmitPasswordEvent()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
