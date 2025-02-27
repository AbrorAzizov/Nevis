part of 'code_screen_bloc.dart';

class CodeScreenState extends Equatable {
  final String? correctCode;
  final String? phone;
  final String code;
  final bool isButtonActive;
  final bool canRequestNewCode;
  final int secondsLeft;
  final bool showError;

  const CodeScreenState({
    this.correctCode,
    this.phone,
    this.code = '',
    this.isButtonActive = false,
    this.canRequestNewCode = false,
    this.secondsLeft = 30,
    this.showError = false,
  });

  CodeScreenState copyWith({
    String? correctCode,
    String? phone,
    String? code,
    bool? isButtonActive,
    bool? canRequestNewCode,
    int? secondsLeft,
    bool? showError,
  }) {
    return CodeScreenState(
      correctCode: correctCode ?? this.correctCode,
      phone: phone ?? this.phone,
      code: code ?? this.code,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      canRequestNewCode: canRequestNewCode ?? this.canRequestNewCode,
      secondsLeft: secondsLeft ?? this.secondsLeft,
      showError: showError ?? this.showError,
    );
  }

  @override
  List<Object?> get props => [
        correctCode,
        phone,
        code,
        isButtonActive,
        canRequestNewCode,
        secondsLeft,
        showError
      ];
}

class SuccessPasteState extends CodeScreenState {
  const SuccessPasteState({
    super.phone,
    super.correctCode,
  });

  @override
  List<Object?> get props => [phone, correctCode];
}
