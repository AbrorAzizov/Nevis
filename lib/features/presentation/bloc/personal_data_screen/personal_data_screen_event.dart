part of 'personal_data_screen_bloc.dart';

abstract class PersonalDataScreenEvent extends Equatable {
  const PersonalDataScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends PersonalDataScreenEvent {
  const LoadDataEvent();
}

class ChangeNotificationCheckboxEvent extends PersonalDataScreenEvent {
  final bool isCheckedNotificationCheckbox;
  const ChangeNotificationCheckboxEvent(this.isCheckedNotificationCheckbox);
}

class ChangeGenderEvent extends PersonalDataScreenEvent {
  final GenderType gender;
  const ChangeGenderEvent(this.gender);
}

class SubmitEvent extends PersonalDataScreenEvent {}

class DeleteAccountEvent extends PersonalDataScreenEvent {}

class ChangeBirthdayEvent extends PersonalDataScreenEvent {
  final DateTime date;
  const ChangeBirthdayEvent(this.date);
}
