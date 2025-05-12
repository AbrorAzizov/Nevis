import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/authentification_param.dart';
import 'package:nevis/features/domain/usecases/auth/login.dart';
import 'package:nevis/features/domain/usecases/auth/request_code.dart';

part 'code_screen_event.dart';
part 'code_screen_state.dart';

class CodeScreenBloc extends Bloc<CodeScreenEvent, CodeScreenState> {
  late BuildContext screenContext;
  final RequestCodeUC requestCodeUC;
  final LoginUC loginUC;

  static const int _initialTimerValue =
      60; // Значение таймера по умолчанию (60 секунд)
  Timer? _timer;

  final TextEditingController codeController =
      TextEditingController(); // Контроллер для кода

  final FocusNode codeFocusNode = FocusNode(); // FocusNode для поля ввода кода

  CodeScreenBloc({
    required this.loginUC,
    required this.requestCodeUC,
    String? phone,
    BuildContext? context,
    String? code,
  }) : super(CodeScreenState(phone: phone)) {
    screenContext = context!;
    on<CodeChangedEvent>(_onCodeChanged);
    on<TimerTickEvent>(_onTimerTick);
    on<SubmitCodeEvent>(_onSubmitCode);
    on<RequestNewCodeEvent>(_requestNewCode);

    // Навешивание листенера на TextEditingController
    codeController.addListener(_codeListener);
    startTimer(screenContext);
  }

  // Листенер для отслеживания изменений в коде
  void _codeListener() {
    final code = codeController.text;
    if (code.length <= 4) {
      add(CodeChangedEvent(code)); // Вызываем событие изменения кода
    }

    if (code.length == 4) {
      codeFocusNode.unfocus(); // Сбрасываем фокус, если введено 4 цифры
    }

    // Сбрасываем ошибку при любом изменении текста
    emit(state.copyWith(showError: false));
  }

  // Обработка изменения кода
  void _onCodeChanged(CodeChangedEvent event, Emitter<CodeScreenState> emit) {
    final isFilled = event.code.length == 4; // Если код содержит 4 символа
    emit(state.copyWith(
      code: event.code,
      isButtonActive: isFilled, // Кнопка активна, если код заполнен
    ));
  }

  // Обработка нажатия на кнопку "Войти"
  void _onSubmitCode(
      SubmitCodeEvent event, Emitter<CodeScreenState> emit) async {
    emit(state.copyWith(showError: false));

    final failureOrLoads = await loginUC(AuthenticationParams(
        phone: Utils.formatPhoneNumber(state.phone), code: state.code));
    failureOrLoads.fold(
      (failure) => switch (failure) {
        TooManyRequestsFailure e => emit(state.copyWith(
            showError: true,
            codeErrorText: e.message ?? 'Слишком много запросов')),
        ConfirmationCodeWrongFailure _ =>
          emit(state.copyWith(showError: true, codeErrorText: 'Неверный код')),
        ServerFailure _ => emit(state.copyWith(
            showError: true, codeErrorText: 'Неизвестная ошибка')),
        _ => emit(state.copyWith(
            showError: true, codeErrorText: 'Неизвестная ошибка')),
      },
      (_) {
        emit(state.copyWith(showError: false));
        emit(CorrectedCodeState());
      },
    );
  }

  void _requestNewCode(
      RequestNewCodeEvent event, Emitter<CodeScreenState> emit) async {
    final failureOrLoads = await requestCodeUC(AuthenticationParams(
      phone: Utils.formatPhoneNumber(state.phone),
    ));
    failureOrLoads.fold(
      (failure) => switch (failure) {
        PhoneDontFoundFailure _ => emit(state.copyWith(
            showError: true, codeErrorText: 'Неправильный номер или пароль')),
        UncorrectedPasswordFailure _ => emit(state.copyWith(
            showError: true, codeErrorText: 'Неправильный номер или пароль')),
        ServerFailure _ => emit(state.copyWith(
            showError: true, codeErrorText: 'Неизвестная ошибка')),
        _ => emit(state.copyWith(
            showError: true, codeErrorText: 'Неизвестная ошибка')),
      },
      (_) {
        emit(state.copyWith(showError: false));
        reset();
        startTimer(screenContext);
      },
    );
  }

  // Обработка каждого тика таймера
  void _onTimerTick(TimerTickEvent event, Emitter<CodeScreenState> emit) {
    if (event.secondsLeft == 0) {
      _timer?.cancel(); // Остановка таймера, если время вышло
      emit(state.copyWith(
          canRequestNewCode: true)); // Разрешение на запрос нового кода
    } else {
      emit(state.copyWith(
          secondsLeft: event.secondsLeft)); // Обновление оставшегося времени
    }
  }

// Функция запуска таймера
  Future<void> startTimer(BuildContext context,
      {Future<String?> Function()? requestCodeFun, String? phone}) async {
    _timer?.cancel();
    String? codeOrMsg;
    emit(
      state.copyWith(
        phone: phone,
        correctCode: phone == state.phone && state.correctCode != null
            ? state.correctCode
            : codeOrMsg,
        secondsLeft: phone == state.phone && state.correctCode != null
            ? state.secondsLeft
            : _initialTimerValue,
        canRequestNewCode:
            false, // Сброс таймера и запрет на запрос нового кода
      ),
    );

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final newTime = state.secondsLeft - 1;
        add(TimerTickEvent(
            newTime)); // Генерация события для каждого тика таймера
      },
    );
  }

  Future reset({String? phone}) async {
    if (phone == state.phone && state.correctCode != null) _timer?.cancel();
    add(CodeChangedEvent(""));
    codeController.text = "";
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Остановка таймера при закрытии блока
    codeController.dispose(); // Освобождаем ресурсы TextEditingController
    codeFocusNode.dispose(); // Освобождаем ресурсы FocusNode
    return super.close();
  }
}
