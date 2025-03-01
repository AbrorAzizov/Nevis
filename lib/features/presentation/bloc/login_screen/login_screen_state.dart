part of 'login_screen_bloc.dart';

class LoginScreenState extends Equatable {
  final bool isButtonActive;
  final String? phoneErrorText;
  final String? passwordErrorText;
  final bool showError;

  // New properties for validation
  final bool isValidPhone;

  const LoginScreenState({
    this.isButtonActive = false,
    this.phoneErrorText,
    this.passwordErrorText,
    this.showError = false,
    this.isValidPhone = false,
  });

  LoginScreenState copyWith({
    bool? isButtonActive,
    String? phoneErrorText,
    String? passwordErrorText,
    bool? showError,
    bool? isValidPhone,
    bool? isValidPassword,
    bool resetPhoneErrorText = false,
    bool resetPasswordErrorText = false,
  }) {
    return LoginScreenState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
      phoneErrorText:
          resetPhoneErrorText ? null : phoneErrorText ?? this.phoneErrorText,
      passwordErrorText: resetPasswordErrorText
          ? null
          : passwordErrorText ?? this.passwordErrorText,
      showError: showError ?? this.showError,
      isValidPhone: isValidPhone ?? this.isValidPhone,
    );
  }

  @override
  List<Object?> get props => [
        isButtonActive,
        phoneErrorText,
        passwordErrorText,
        showError,
        isValidPhone,
      ];
}

class LogInState extends LoginScreenState {}
