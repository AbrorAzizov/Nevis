part of 'code_screen_bloc.dart';

abstract class CodeScreenEvent extends Equatable {
  const CodeScreenEvent();

  @override
  List<Object> get props => [];
}

class CodeChangedEvent extends CodeScreenEvent {
  final String code;

  const CodeChangedEvent(this.code);

  @override
  List<Object> get props => [code];
}

class RequestNewCodeEvent extends CodeScreenEvent {}

class TimerTickEvent extends CodeScreenEvent {
  final int secondsLeft;

  const TimerTickEvent(this.secondsLeft);

  @override
  List<Object> get props => [secondsLeft];
}

class SubmitCodeEvent extends CodeScreenEvent {}
