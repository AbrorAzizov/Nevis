part of 'password_screen_bloc.dart';

abstract class PasswordScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PasswordChangedEvent extends PasswordScreenEvent {
  final String password;

  PasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}

class SubmitPasswordEvent extends PasswordScreenEvent {}
