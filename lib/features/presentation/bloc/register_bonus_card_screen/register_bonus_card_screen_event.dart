part of 'register_bonus_cardscreen_bloc.dart';

abstract class RegisterBonusCardScreenEvent extends Equatable {
  const RegisterBonusCardScreenEvent();

  @override
  List<Object> get props => [];
}

class ChangeNotificationCheckboxEvent extends RegisterBonusCardScreenEvent {
  final bool isCheckedNotificationCheckbox;
  const ChangeNotificationCheckboxEvent(this.isCheckedNotificationCheckbox);
}

class ChangePolicyCheckboxEvent extends RegisterBonusCardScreenEvent {
  final bool isCheckedPolicyCheckbox;
  const ChangePolicyCheckboxEvent(this.isCheckedPolicyCheckbox);
}

class ChangeGenderEvent extends RegisterBonusCardScreenEvent {
  final GenderType gender;
  const ChangeGenderEvent(this.gender);
}

class SubmitEvent extends RegisterBonusCardScreenEvent {}

class PasswordChangedEvent extends RegisterBonusCardScreenEvent {}

class ConfirmPhoneChangeEvent extends RegisterBonusCardScreenEvent {
  final String confirmPhoneCode;
  const ConfirmPhoneChangeEvent(this.confirmPhoneCode);
}

class DeleteAccountEvent extends RegisterBonusCardScreenEvent {}
