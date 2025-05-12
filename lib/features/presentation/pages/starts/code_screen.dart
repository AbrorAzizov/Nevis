import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/code_screen/code_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_message.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/app_template.dart';
import 'package:nevis/features/presentation/widgets/pinput_widget.dart';
import 'package:nevis/locator_service.dart';

class CodeScreen extends StatelessWidget {
  const CodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    CodeScreenType codeScreenType = args!['redirect_type'];
    final bool logInWithMessage =
        codeScreenType == CodeScreenType.logInWithMessage;

    return BlocProvider(
      create: (context) => CodeScreenBloc(
        context: context,
        requestCodeUC: sl(),
        phone: args['phone'],
        loginUC: sl(),
      ),
      child: BlocConsumer<CodeScreenBloc, CodeScreenState>(
        listener: (context, state) {
          if (state.showError) {
            Get.closeAllSnackbars();
            Get.showSnackbar(GetSnackBar(
              snackPosition: SnackPosition.TOP,
              title: 'Ошибка',
              duration: Duration(seconds: 2),
              message: state.codeErrorText,
            ));
          } else if (state is CorrectedCodeState) {
            /*context
                .read<FavoriteProductsScreenBloc>()
                .add(LoadFavoriteProductsEvent());*/
            Navigator.popUntil(
              context,
              (route) {
                debugPrint('Route name: ${route.settings.name}');
                return route.settings.name == Routes.homeScreen;
              },
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<CodeScreenBloc>();
          return AppTemplate(
            heightOfTopBar: 250,
            canBack: true,
            title: 'Введите код',
            subTitleWidget: RichText(
              text: logInWithMessage
                  ? TextSpan(
                      children: [
                        WidgetSpan(
                          child: SizedBox(height: 30.h),
                        ),
                        TextSpan(
                          text: 'Вам поступит смс с кодом на номер\n',
                          style: UiConstants.textStyle2
                              .copyWith(color: UiConstants.whiteColor),
                        ),
                        TextSpan(
                          text: state.phone,
                          style: UiConstants.textStyle2.copyWith(
                              color: UiConstants.whiteColor,
                              fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text: '. \nВведите код в поле ниже',
                          style: UiConstants.textStyle2
                              .copyWith(color: UiConstants.whiteColor),
                        ),
                      ],
                    )
                  : TextSpan(
                      children: [
                        WidgetSpan(
                          child: SizedBox(height: 30.h),
                        ),
                        TextSpan(
                          text: 'Вам поступит звонок от робота на номер\n',
                          style: UiConstants.textStyle2
                              .copyWith(color: UiConstants.whiteColor),
                        ),
                        TextSpan(
                          text: state.phone,
                          style: UiConstants.textStyle2.copyWith(
                              color: UiConstants.whiteColor,
                              fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text:
                              '. \nВведите последние 4 цифры входяшего номера.',
                          style: UiConstants.textStyle2
                              .copyWith(color: UiConstants.whiteColor),
                        ),
                      ],
                    ),
            ),
            body: logInWithMessage
                ? Column(
                    children: [
                      PinputWidget(
                          controller: bloc.codeController,
                          focusNode: bloc.codeFocusNode,
                          showError: state.showError),
                      SizedBox(height: 32.h),
                      AppButtonWidget(
                          isActive: state.isButtonActive,
                          text: 'Войти',
                          onTap: () {
                            // bloc.add()
                          }),
                      SizedBox(height: 16.h),
                      if (state.canRequestNewCode)
                        GestureDetector(
                          onTap: () => bloc.add(RequestNewCodeEvent()),
                          child: Text(
                            'Запросить звонок снова',
                            style: UiConstants.textStyle3
                                .copyWith(color: UiConstants.blueColor),
                          ),
                        )
                      else
                        Text(
                          'Запрос нового кода доступен через ${Utils.formatSecondToMMSS(state.secondsLeft)}',
                          style: UiConstants.textStyle3
                              .copyWith(color: UiConstants.mutedVioletColor),
                        ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        'Запросить новый код',
                        style: UiConstants.textStyle3
                            .copyWith(color: UiConstants.blueColor),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      PinputWidget(
                          controller: bloc.codeController,
                          focusNode: bloc.codeFocusNode,
                          showError: state.showError),
                      SizedBox(height: 32.h),
                      AppButtonWidget(
                          isActive: state.isButtonActive,
                          text: 'Войти',
                          onTap: () {
                            bloc.add(SubmitCodeEvent());
                          }),
                      SizedBox(height: 16.h),
                      if (state.canRequestNewCode)
                        GestureDetector(
                          onTap: () => bloc.add(RequestNewCodeEvent()),
                          child: Text(
                            'Запросить звонок снова',
                            style: UiConstants.textStyle3
                                .copyWith(color: UiConstants.purpleColor),
                          ),
                        )
                      else
                        Text(
                          'Запрос нового звонка доступен через ${Utils.formatSecondToMMSS(state.secondsLeft)}',
                          style: UiConstants.textStyle3
                              .copyWith(color: UiConstants.mutedVioletColor),
                        ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            Routes.createRoute(
                              const LoginScreenWithMessage(),
                              settings: RouteSettings(
                                name: Routes.loginScreenWithMessage,
                                arguments: {
                                  'redirect_type':
                                      LoginScreenType.logInWithMessage,
                                },
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Не поступает звонок?',
                          style: UiConstants.textStyle3
                              .copyWith(color: UiConstants.blueColor),
                        ),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
