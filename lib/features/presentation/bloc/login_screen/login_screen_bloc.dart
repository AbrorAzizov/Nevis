import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/authentification_param.dart';
import 'package:nevis/features/domain/usecases/auth/request_code.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final RequestCodeUC requestCodeUC;

  final TextEditingController phoneController = TextEditingController();

  LoginScreenBloc({required this.requestCodeUC, Map<String, dynamic>? args})
      : super(const LoginScreenState()) {
    if (args?['redirect_type'] == LoginScreenType.accountExists) {
      phoneController.text = args?['phone'] ?? '';
    }

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
            PhoneDontFoundFailure _ => emit(state.copyWith(
                showError: true,
                passwordErrorText: 'Неправильный номер или пароль')),
            UncorrectedPasswordFailure _ => emit(state.copyWith(
                showError: true,
                passwordErrorText: 'Неправильный номер или пароль')),
            ServerFailure _ => emit(state.copyWith(
                showError: true, passwordErrorText: 'Неизвестная ошибка')),
            _ => emit(state.copyWith(
                showError: true, passwordErrorText: 'Неизвестная ошибка')),
          },
          (_) {
            emit(state.copyWith(showError: false));
            emit(CodeSuccesefullyDelivired());
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}
