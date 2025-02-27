import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/formatters/custom_phone_input_formatter.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/sign_up_screen/sign_up_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/sign_up_screen/sign_up_screen_state.dart';
import 'package:nevis/features/presentation/pages/starts/account_not_found_screen.dart';
import 'package:nevis/features/presentation/pages/starts/code_screen.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/app_template.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/features/presentation/widgets/policy_text_widget.dart';
import 'package:nevis/locator_service.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    PasswordScreenType passwordScreenType = args!['redirect_type'];

    return BlocProvider(
      create: (context) => SignUpScreenBloc(
        isPhoneExistsUC: sl(),
        passwordScreenType: passwordScreenType,
        phone: args['phone'],
      ),
      child: BlocConsumer<SignUpScreenBloc, SignUpScreenState>(
        listener: (context, state) {
          final bloc = context.read<SignUpScreenBloc>();

          if (state is AccountAlreadyExistsState) {
            Navigator.of(context).push(
              Routes.createRoute(
                const LoginScreen(),
                settings: RouteSettings(
                  name: Routes.loginScreen,
                  arguments: {
                    'redirect_type': LoginScreenType.accountExists,
                    'phone': bloc.phoneController.text
                  },
                ),
              ),
            );
          } else if (state is NotFoundAccountState) {
            Navigator.of(context).push(
              Routes.createRoute(
                const AccountNotFoundScreen(),
                settings: RouteSettings(
                  name: Routes.accountNotFoundScreen,
                  arguments: {'phone': bloc.phoneController.text},
                ),
              ),
            );
          } else if (state is GetCodeState) {
            Navigator.of(context).push(
              Routes.createRoute(
                const CodeScreen(),
                settings: RouteSettings(
                  name: Routes.codeScreen,
                  arguments: {
                    'redirect_type': passwordScreenType,
                    'phone': bloc.phoneController.text
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<SignUpScreenBloc>();

          return AppTemplate(
            canBack: true,
            title: passwordScreenType == PasswordScreenType.signUp
                ? 'Регистрация'
                : 'Восстановление пароля',
            subTitleText: passwordScreenType == PasswordScreenType.signUp
                ? 'Зарегистрируйтесь, чтобы совершать покупки, копить бонусы и иметь быстрый доступ к карте лояльности.'
                : 'Введите номер телефона, который был использован при регистрации:',
            bodyPadding:
                getMarginOrPadding(left: 20, right: 20, top: 16, bottom: 24),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextFieldWidget(
                  title: 'Телефон',
                  hintText: '+375 (00) 000-00-00',
                  controller: bloc.phoneController,
                  errorText: state.phoneErrorText,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CustomPhoneInputFormatter()
                  ],
                ),
                SizedBox(height: 32.h),
                AppButtonWidget(
                  isActive: state.isValidPhone,
                  text: 'Получить код',
                  onTap: () => bloc.add(GetCodeEvent()),
                ),
                if (passwordScreenType == PasswordScreenType.signUp)
                  Expanded(
                    child: Padding(
                      padding: getMarginOrPadding(top: 32),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Уже есть аккаунт?',
                                style: UiConstants.textStyle3.copyWith(
                                  color: UiConstants.darkBlue2Color
                                      .withOpacity(.6),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Text(
                                  'Войти',
                                  style: UiConstants.textStyle3
                                      .copyWith(color: UiConstants.purpleColor),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: PolicyTextWidget(),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
