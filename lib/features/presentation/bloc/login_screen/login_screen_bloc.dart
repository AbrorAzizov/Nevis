import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:flutter_login_yandex/flutter_login_yandex.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/authentification_param.dart';
import 'package:nevis/core/params/login_servece_param.dart';
import 'package:nevis/features/domain/usecases/auth/login_by_service.dart';
import 'package:nevis/features/domain/usecases/auth/request_code.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final RequestCodeUC requestCodeUC;
  final LoginByServiceUC loginByService;

  final TextEditingController phoneController = TextEditingController();

  LoginScreenBloc(
      {required this.requestCodeUC,
      required this.loginByService,
      Map<String, dynamic>? args})
      : super(const LoginScreenState()) {
    if (args?['redirect_type'] == LoginScreenType.accountExists) {
      phoneController.text = args?['phone'] ?? '';
    }

    on<LoginByVkEvent>(_onLoginByVk);
    on<LoginByYandexEvent>(_onLoginByYandex);

    phoneController.addListener(() {
      add(PhoneChangedEvent(phoneController.text));
    });

    // Регистрация обработчиков событий
    on<PhoneChangedEvent>((event, emit) {
      final isValidPhone = Utils.phoneRegexp.hasMatch(event.phone);
      if (event.phone.length == 18 && !isValidPhone) {
        emit(
          state.copyWith(
              isValidPhone: isValidPhone,
              isButtonActive: isValidPhone,
              phoneErrorText: 'Неверный формат телефона',
              resetPasswordErrorText: true,
              showError: true,
              resetPhoneErrorText: false),
        );
      } else {
        emit(state.copyWith(
            isValidPhone: isValidPhone,
            isButtonActive: isValidPhone,
            resetPasswordErrorText: true,
            phoneErrorText: null,
            resetPhoneErrorText: true));
      }
    });

    on<SendCodeEvent>(
      (event, emit) async {
        final failureOrLoads = await requestCodeUC(AuthenticationParams(
          phone: Utils.formatPhoneNumber(phoneController.text),
        ));
        failureOrLoads.fold(
          (failure) => switch (failure) {
            TooManyRequestsFailure e => emit(state.copyWith(
                showError: true,
                phoneErrorText: e.message ??
                    'Слишком много попыток входа , попробуйте позже')),
            PhoneDontFoundFailure _ => emit(state.copyWith(
                showError: true,
                phoneErrorText: 'Неправильный номер или пароль')),
            ServerFailure _ => emit(state.copyWith(
                showError: true, phoneErrorText: 'Неизвестная ошибка')),
            _ => emit(state.copyWith(
                showError: true, phoneErrorText: 'Неизвестная ошибка')),
          },
          (_) {
            emit(state.copyWith(showError: false));
            emit(CodeSuccesefullyDelivired());
          },
        );
      },
    );
  }

  Future<void> _onLoginByVk(
      LoginByVkEvent event, Emitter<LoginScreenState> emit) async {
    final vk = VKLogin();
    await vk.initSdk();
    final res = await vk.logIn(scope: [
      VKScope.email,
      VKScope.friends,
    ]);

    if (res.isValue) {
      final VKLoginResult result = res.asValue!.value;

      if (result.isCanceled) {
      } else {
        final VKAccessToken? vkToken = result.accessToken;
        // Send access token to server for validation and auth
        if (vkToken != null) {
          final failureOrLoads = await loginByService(
            LoginServiceParam(
                serviceToken: vkToken.token,
                loginServiceType: LoginServiceType.vk),
          );
          failureOrLoads.fold(
            (failure) => switch (failure) {
              TooManyRequestsFailure e => emit(state.copyWith(
                  showError: true,
                  phoneErrorText: e.message ??
                      'Слишком много попыток входа , попробуйте позже')),
              ServerFailure _ => emit(state.copyWith(
                  showError: true, phoneErrorText: 'Неизвестная ошибка')),
              _ => emit(state.copyWith(
                  showError: true, phoneErrorText: 'Неизвестная ошибка')),
            },
            (_) {
              emit(state.copyWith(showError: false));
              emit(LoginServiceSuccessfully());
            },
          );
        }
      }
    }
  }

  Future<void> _onLoginByYandex(
      LoginByYandexEvent event, Emitter<LoginScreenState> emit) async {
    final flutterLoginYandexPlugin = FlutterLoginYandex();
    final response = await flutterLoginYandexPlugin.signIn();
    final String? yandexToken = response?['token'] as String?;
    if (yandexToken != null) {
      final failureOrLoads = await loginByService(
        LoginServiceParam(
            serviceToken: yandexToken,
            loginServiceType: LoginServiceType.yandex),
      );
      failureOrLoads.fold(
        (failure) => switch (failure) {
          TooManyRequestsFailure e => emit(state.copyWith(
              showError: true,
              phoneErrorText: e.message ??
                  'Слишком много попыток входа , попробуйте позже')),
          ServerFailure _ => emit(state.copyWith(
              showError: true, phoneErrorText: 'Неизвестная ошибка')),
          _ => emit(state.copyWith(
              showError: true, phoneErrorText: 'Неизвестная ошибка')),
        },
        (_) {
          emit(state.copyWith(showError: false));
          emit(LoginServiceSuccessfully());
        },
      );
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}
