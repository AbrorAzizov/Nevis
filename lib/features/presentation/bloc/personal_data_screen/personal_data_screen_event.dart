part of 'personal_data_screen_bloc.dart';

abstract class PersonalDataScreenEvent extends Equatable {
  const PersonalDataScreenEvent();

  @override
  List<Object> get props => [];
}

class ChangeNotificationCheckboxEvent extends PersonalDataScreenEvent {
  final bool isCheckedNotificationCheckbox;
  const ChangeNotificationCheckboxEvent(this.isCheckedNotificationCheckbox);
}

class ChangePolicyCheckboxEvent extends PersonalDataScreenEvent {
  final bool isCheckedPolicyCheckbox;
  const ChangePolicyCheckboxEvent(this.isCheckedPolicyCheckbox);
}

class ChangeGenderEvent extends PersonalDataScreenEvent {
  final GenderType gender;
  const ChangeGenderEvent(this.gender);
}

class SubmitEvent extends PersonalDataScreenEvent {}

class PasswordChangedEvent extends PersonalDataScreenEvent {}

class ConfirmPhoneChangeEvent extends PersonalDataScreenEvent {
  final String confirmPhoneCode;
  const ConfirmPhoneChangeEvent(this.confirmPhoneCode);
}

class DeleteAccountEvent extends PersonalDataScreenEvent {}

class LoadProfileEvent extends PersonalDataScreenEvent {}
