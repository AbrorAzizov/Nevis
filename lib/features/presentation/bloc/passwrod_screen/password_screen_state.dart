part of 'password_screen_bloc.dart';

class PasswordScreenState extends Equatable {
  final String? phone;
  final String? code;
  final bool isButtonActive;
  final String? passwordErrorText;
  final bool showError;

  const PasswordScreenState({
    this.phone,
    this.code,
    this.isButtonActive = false,
    this.passwordErrorText,
    this.showError = false,
  });

  PasswordScreenState copyWith({
    String? phone,
    String? code,
    bool? isButtonActive,
    String? passwordErrorText,
    bool? showError,
  }) {
    return PasswordScreenState(
      phone: phone ?? this.phone,
      code: code ?? this.code,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      passwordErrorText: passwordErrorText,
      showError: showError ?? this.showError,
    );
  }

  @override
  List<Object?> get props => [
        isButtonActive,
        passwordErrorText,
        showError,
      ];
}

class NavigateHomeState extends PasswordScreenState {}

class NavigateLoginState extends PasswordScreenState {}
