import 'package:equatable/equatable.dart';

class SignUpScreenState extends Equatable {
  final String? phoneErrorText;
  final bool showError;
  final bool isValidPhone;

  const SignUpScreenState({
    this.phoneErrorText,
    this.showError = false,
    this.isValidPhone = false,
  });

  SignUpScreenState copyWith({
    String? phoneErrorText,
    bool? showError,
    bool? isValidPhone,
  }) {
    return SignUpScreenState(
      phoneErrorText: phoneErrorText,
      showError: showError ?? this.showError,
      isValidPhone: isValidPhone ?? this.isValidPhone,
    );
  }

  @override
  List<Object?> get props => [phoneErrorText, showError, isValidPhone];
}

class AccountAlreadyExistsState extends SignUpScreenState {}

class GetCodeState extends SignUpScreenState {}

class NotFoundAccountState extends SignUpScreenState {}
