part of 'login_screen_bloc.dart';

class LoginScreenState extends Equatable {
  final bool isButtonActive;
  final String? phoneErrorText;
  final bool showError;

  // New properties for validation
  final bool isValidPhone;

  const LoginScreenState({
    this.isButtonActive = false,
    this.phoneErrorText,
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
      showError: showError ?? this.showError,
      isValidPhone: isValidPhone ?? this.isValidPhone,
    );
  }

  @override
  List<Object?> get props => [
        isButtonActive,
        phoneErrorText,
        showError,
        isValidPhone,
      ];
}

class CodeSuccesefullyDelivired extends LoginScreenState {}

class LoginServiceSuccessfully extends LoginScreenState {}
