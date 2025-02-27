part of 'login_screen_bloc.dart';

class LoginScreenState extends Equatable {
  final bool isButtonActive;
  final String? phoneErrorText;
  final String? passwordErrorText;
  final bool showError;

  // New properties for validation
  final bool isValidPhone;
  final bool isValidPassword;

  const LoginScreenState({
    this.isButtonActive = false,
    this.phoneErrorText,
    this.passwordErrorText,
    this.showError = false,
    this.isValidPhone = false,
    this.isValidPassword = false,
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
      isValidPassword: isValidPassword ?? this.isValidPassword,
    );
  }

  @override
  List<Object?> get props => [
        isButtonActive,
        phoneErrorText,
        passwordErrorText,
        showError,
        isValidPhone,
        isValidPassword,
      ];
}

class LogInState extends LoginScreenState {}
