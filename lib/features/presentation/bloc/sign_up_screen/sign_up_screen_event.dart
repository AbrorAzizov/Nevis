part of 'sign_up_screen_bloc.dart';

abstract class SignUpScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhoneChangedEvent extends SignUpScreenEvent {
  final String phone;

  PhoneChangedEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class GetCodeEvent extends SignUpScreenEvent {}
