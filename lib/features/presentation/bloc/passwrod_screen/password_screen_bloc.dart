import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/authentification_param.dart';
import 'package:nevis/features/domain/usecases/auth/login.dart';
import 'package:nevis/features/domain/usecases/auth/registration.dart';
import 'package:nevis/features/domain/usecases/auth/update_password.dart';

part 'password_screen_event.dart';
part 'password_screen_state.dart';

class PasswordScreenBloc
    extends Bloc<PasswordScreenEvent, PasswordScreenState> {
  final UpdatePasswordUC updatePasswordUC;
  final RegistrationUC registrationUC;
  final LoginUC loginUC;

  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  PasswordScreenType? _passwordScreenType;

  PasswordScreenBloc(
      {required this.updatePasswordUC,
      required this.registrationUC,
      required this.loginUC,
      String? phone,
      String? code,
      PasswordScreenType? passwordScreenType})
      : super(PasswordScreenState(phone: phone, code: code)) {
    _passwordScreenType = passwordScreenType;

    password1Controller.addListener(() {
      add(PasswordChangedEvent(password1Controller.text));
    });

    password2Controller.addListener(() {
      add(PasswordChangedEvent(password2Controller.text));
    });

    on<PasswordChangedEvent>((event, emit) {
      emit(
        state.copyWith(
            isButtonActive: password1Controller.text.isNotEmpty &&
                password2Controller.text.isNotEmpty,
            passwordErrorText: null,
            showError: false),
      );
    });

    on<SubmitPasswordEvent>(
      (event, emit) async {
        if (password2Controller.text != password1Controller.text) {
          emit(state.copyWith(
            showError: true,
            passwordErrorText: 'Пароли не совпадают',
          ));
          return;
        }

        // Флаг для регистрации или сброса
        bool successSignUpOrResetScreen =
            _passwordScreenType == PasswordScreenType.reset;

        if (_passwordScreenType == PasswordScreenType.signUp) {
          final failureOrLoads = await registrationUC(
            AuthenticationParams(
              phone: Utils.formatPhoneNumber(state.phone!),
              code: state.code,
            ),
          );

          await failureOrLoads.fold(
            (failure) async {
              switch (failure) {
                case PhoneDontFoundFailure _:
                  emit(state.copyWith(
                    showError: true,
                    passwordErrorText: 'Телефон не зарегистрирован',
                  ));
                  break;
                case PhoneAlreadyTakenFailure _:
                  emit(state.copyWith(
                    showError: true,
                    passwordErrorText: 'Телефон уже зарегистрирован',
                  ));
                  break;
                default:
                  emit(state.copyWith(
                    showError: true,
                    passwordErrorText: 'Неизвестная ошибка',
                  ));
                  break;
              }
            },
            (_) async {
              successSignUpOrResetScreen = true;
            },
          );
        }

        if (successSignUpOrResetScreen) {
          final failureOrLoads = await updatePasswordUC(
            AuthenticationParams(
              phone: Utils.formatPhoneNumber(state.phone!),
              password: password1Controller.text,
              code: state.code,
            ),
          );

          await failureOrLoads.fold(
            (failure) async {
              switch (failure) {
                case AccountDontExistsFailure _:
                  emit(state.copyWith(
                    showError: true,
                    passwordErrorText: 'Аккаунта с таким номером не существует',
                  ));
                  break;
                case PasswordMatchesPreviousOneFailure _:
                  emit(state.copyWith(
                    showError: true,
                    passwordErrorText: 'Пароль должен отличатся от старого',
                  ));
                  break;
                case SessionExpiredFailure _:
                  emit(state.copyWith(
                    showError: true,
                    passwordErrorText: 'Сессия истекла или код не был запрошен',
                  ));
                  break;
                case ConfirmationCodeWrongException _:
                  emit(state.copyWith(
                    showError: true,
                    passwordErrorText: 'Код не совпал',
                  ));
                  break;
                default:
                  emit(state.copyWith(
                    showError: true,
                    passwordErrorText: 'Неизвестная ошибка',
                  ));
                  break;
              }
            },
            (_) async {
              final loginResult = await loginUC(
                AuthenticationParams(
                  phone: Utils.formatPhoneNumber(state.phone!),
                  password: password1Controller.text,
                ),
              );

              await loginResult.fold(
                (failure) async {
                  emit(state.copyWith(showError: false));
                  emit(NavigateLoginState());
                },
                (_) async {
                  emit(state.copyWith(showError: false));
                  emit(NavigateHomeState());
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Future<void> close() {
    password1Controller.dispose();
    password2Controller.dispose();
    return super.close();
  }
}
