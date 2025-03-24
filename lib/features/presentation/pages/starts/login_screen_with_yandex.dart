import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/formatters/custom_phone_input_formatter.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/login_screen/login_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/home_screen.dart';
import 'package:nevis/features/presentation/pages/starts/code_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/app_template.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/features/presentation/widgets/policy_text_widget.dart';
import 'package:nevis/locator_service.dart';

class LoginScreenWithYandex extends StatelessWidget {
  const LoginScreenWithYandex({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    LoginScreenType loginScreenType = args!['redirect_type'];
    return BlocProvider(
      create: (context) => LoginScreenBloc(
        args: args, 
        requestCodeUC: sl(),
  
      ),
      child: BlocConsumer<LoginScreenBloc, LoginScreenState>(
        listener: (context, state) async {
          // if (state is LogInState) {
          //   Navigator.of(context).pushAndRemoveUntil(
          //       Routes.createRoute(
          //         const HomeScreen(),
          //       ),
          //       (route) => false);
          // }
        },
        builder: (context, state) {
          final bloc = context.read<LoginScreenBloc>();
          return AppTemplate(
            canBack: true,
            title:  'Авторизация',
            subTitleText:
                'Войдите, чтобы совершать покупки,\nкопить бонусы и иметь быстрый доступ к карте лояльности',
            bodyPadding:
                getMarginOrPadding(left: 20, right: 20, top: 16, bottom: 24),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Paths.yandexLogInIconPath),
                  ],
                ),
                SizedBox(height: 32.h,),
                    AppTextFieldWidget(
                  fillColor: UiConstants.whiteColor,
                  title: 'Введите номер телефона',
                  hintText: '+7 (800) 000 00 00',
                  controller: bloc.phoneController,
                  errorText: state.phoneErrorText,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CustomPhoneInputFormatter()
                  ],
                ),
                SizedBox(height: 16.h),
                AppButtonWidget(
                    isActive: state.isButtonActive,
                    text: 'Войти',
                    onTap: () {
                      Navigator.pop(context);
                    }
                    ),
                SizedBox(
                  height: 32.h,
                ),
                PolicyTextWidget(),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
