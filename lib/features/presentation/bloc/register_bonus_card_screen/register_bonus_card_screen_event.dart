part of 'register_bonus_card_screen_bloc.dart';

abstract class RegisterBonusCardScreenEvent extends Equatable {
  const RegisterBonusCardScreenEvent();

  @override
  List<Object> get props => [];
}

class ChangeGenderEvent extends RegisterBonusCardScreenEvent {
  final GenderType gender;
  const ChangeGenderEvent(this.gender);
}

class ChangeBirthdayEvent extends RegisterBonusCardScreenEvent {
  final DateTime date;
  const ChangeBirthdayEvent(this.date);
}

class SubmitEvent extends RegisterBonusCardScreenEvent {
  const SubmitEvent();
}
