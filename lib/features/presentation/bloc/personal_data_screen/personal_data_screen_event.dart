part of 'personal_data_screen_bloc.dart';

abstract class PersonalDataScreenEvent extends Equatable {
  const PersonalDataScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends PersonalDataScreenEvent {
  final BuildContext context;
  const LoadProfileEvent({required this.context});
}

class ChangeNotificationCheckboxEvent extends PersonalDataScreenEvent {
  final bool isCheckedNotificationCheckbox;
  const ChangeNotificationCheckboxEvent(this.isCheckedNotificationCheckbox);
}

class ChangeGenderEvent extends PersonalDataScreenEvent {
  final GenderType gender;
  const ChangeGenderEvent(this.gender);
}

class SubmitEvent extends PersonalDataScreenEvent {
  final BuildContext context;
  const SubmitEvent({required this.context});
}

class DeleteAccountEvent extends PersonalDataScreenEvent {
  final BuildContext context;
  const DeleteAccountEvent({required this.context});
}

class ChangeBirthdayEvent extends PersonalDataScreenEvent {
  final DateTime date;
  const ChangeBirthdayEvent(this.date);
}
