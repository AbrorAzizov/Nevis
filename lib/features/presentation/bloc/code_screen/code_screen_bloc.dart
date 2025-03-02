import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/params/authentification_param.dart';
import 'package:nevis/features/domain/usecases/auth/request_code.dart';

part 'code_screen_event.dart';
part 'code_screen_state.dart';

class CodeScreenBloc extends Bloc<CodeScreenEvent, CodeScreenState> {
  late BuildContext screenContext;

  final RequestCodeUC requestCodeUC;

  static const int _initialTimerValue =
      60; // Значение таймера по умолчанию (60 секунд)
  Timer? _timer;

  final TextEditingController codeController =
      TextEditingController(); // Контроллер для кода

  final FocusNode codeFocusNode = FocusNode(); // FocusNode для поля ввода кода

  CodeScreenBloc({
    required this.requestCodeUC,
    String? phone,
    BuildContext? context,
    String? code,
  }) : super(CodeScreenState(phone: phone)) {
    screenContext = context!;
    on<CodeChangedEvent>(_onCodeChanged); // Событие изменения кода
    on<RequestNewCodeEvent>(_onRequestNewCode); // Событие запроса нового кода
    on<TimerTickEvent>(_onTimerTick); // Событие изменения таймера
    on<SubmitCodeEvent>(_onSubmitCode); // Событие нажатия кнопки "Войти"

    // Навешивание листенера на TextEditingController
    codeController.addListener(_codeListener);
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
  void _onSubmitCode(SubmitCodeEvent event, Emitter<CodeScreenState> emit) {
    if (state.code == state.correctCode) {
      // Если код верный, ошибки нет
      emit(state.copyWith(showError: false));
      emit(SuccessPasteState(
          phone: state.phone, correctCode: state.correctCode));
    } else {
      // Если код неверный, показать ошибку
      emit(state.copyWith(showError: true));
    }
  }

  // Обработка запроса нового кода
  void _onRequestNewCode(
      RequestNewCodeEvent event, Emitter<CodeScreenState> emit) {
    _timer?.cancel(); // Остановка предыдущего таймера
    startTimer(screenContext); // Запуск нового таймера
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

    // Вызываем функцию, если она предоставлена, иначе используем _requestCode
    String? codeOrMsg = requestCodeFun != null
        ? await requestCodeFun() // Вызов функции
        : null;
        //await _requestCode(); // Вызов метода _requestCode

    if (double.tryParse(codeOrMsg!) != null ||
        (phone == state.phone && state.correctCode != null)) {
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
    } else if (codeOrMsg != 'null') {
      // Показ диалогового окна с крестиком и сообщением
      Utils.showCustomDialog(
        screenContext: context,
        text: codeOrMsg,
        action: (_) {
          Navigator.of(screenContext).pop();
          Navigator.of(screenContext).pop();
        },
      );
    }
  }

  Future<String> _requestCode() async {
    final failureOrLoads = await requestCodeUC(
      AuthenticationParams(
        phone: Utils.formatPhoneNumber(state.phone!),
      ),
    );

    // отправка кода
    return failureOrLoads.fold(
      (failure) => switch (failure) {
        SendingCodeTooOftenFailure _ =>
          'Слишком частая отправка кода или превышено число попыток за день, введите предыдущий код',
        ServerFailure _ => 'Неизвестная ошибка',
        _ => 'Неизвестная ошибка',
      },
      (code) => code.toString(),
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
