part of 'personal_data_screen_bloc.dart';

class PersonalDataScreenState extends Equatable {
  final bool isLoading;
  final bool isButtonActive;
  final GenderType? gender;
  final bool isCheckedNotificationCheckbox;
  final DateTime? birthday;
  final bool showError;

  const PersonalDataScreenState({
    this.isLoading = true,
    this.isButtonActive = true,
    this.gender = GenderType.M,
    this.isCheckedNotificationCheckbox = false,
    this.birthday,
    this.showError = false,
  });

  PersonalDataScreenState copyWith({
    bool? isLoading,
    bool? isButtonActive,
    GenderType? gender,
    bool? isCheckedNotificationCheckbox,
    DateTime? birthday,
    bool? showError,
  }) {
    return PersonalDataScreenState(
      isLoading: isLoading ?? this.isLoading,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      gender: gender ?? this.gender,
      isCheckedNotificationCheckbox:
          isCheckedNotificationCheckbox ?? this.isCheckedNotificationCheckbox,
      birthday: birthday ?? this.birthday,
      showError: showError ?? this.showError,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isButtonActive,
        gender,
        isCheckedNotificationCheckbox,
        birthday,
        showError,
      ];
}

class PersonalDataScreenLoadingState extends PersonalDataScreenState {}

class DeleteAccountState extends PersonalDataScreenState {}
