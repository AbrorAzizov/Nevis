part of 'login_screen_bloc.dart';

abstract class LoginScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhoneChangedEvent extends LoginScreenEvent {
  final String phone;

  PhoneChangedEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class PasswordChangedEvent extends LoginScreenEvent {
  final String password;

  PasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}

class SubmitLoginEvent extends LoginScreenEvent {}
