import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/code_screen/code_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/starts/password_screen.dart';
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

    PasswordScreenType passwordScreenType = args!['redirect_type'];

    return BlocProvider(
      create: (context) => CodeScreenBloc(
        context: context,
        requestCodeUC: sl(),
        phone: args['phone'],
      )..startTimer(context),
      child: BlocConsumer<CodeScreenBloc, CodeScreenState>(
        listener: (context, state) {
          if (state is SuccessPasteState) {
            Navigator.of(context).pushReplacement(
              Routes.createRoute(
                const PasswordScreen(),
                settings: RouteSettings(
                  name: Routes.passwordScreen,
                  arguments: {
                    'redirect_type': passwordScreenType,
                    'phone': state.phone,
                    'code': state.correctCode
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<CodeScreenBloc>();
          return AppTemplate(
            canBack: true,
            title: 'Введите код',
            subTitleWidget: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Мы отправили СМС с кодом на номер ',
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
                    text: '. Введите его здесь:',
                    style: UiConstants.textStyle2
                        .copyWith(color: UiConstants.whiteColor),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                PinputWidget(
                    controller: bloc.codeController,
                    focusNode: bloc.codeFocusNode,
                    showError: state.showError),
                SizedBox(height: 32.h),
                AppButtonWidget(
                  isActive: state.isButtonActive,
                  text: 'Войти',
                  onTap: () => bloc.add(
                    SubmitCodeEvent(),
                  ),
                ),
                SizedBox(height: 16.h),
                if (state.canRequestNewCode)
                  GestureDetector(
                    onTap: () => bloc.add(RequestNewCodeEvent()),
                    child: Text(
                      'Запросить код снова',
                      style: UiConstants.textStyle3
                          .copyWith(color: UiConstants.purpleColor),
                    ),
                  )
                else
                  Text(
                    'Запросить код ещё раз через ${Utils.formatSecondToMMSS(state.secondsLeft)}',
                    style: UiConstants.textStyle3
                        .copyWith(color: UiConstants.mutedVioletColor),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
