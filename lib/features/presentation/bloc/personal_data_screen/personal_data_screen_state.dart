part of 'personal_data_screen_bloc.dart';

class PersonalDataScreenState extends Equatable {
  final bool isLoading;
  final bool isButtonActive;
  final GenderType? gender;
  final bool isCheckedNotificationCheckbox;
  final bool isCheckedNotifictaionAboutApplication;
  final String? passwordErrorText;
  final bool showError;
  final String? confirmPhoneCode;
  final String? installedPhone;

  const PersonalDataScreenState({
    this.isLoading = true,
    this.isButtonActive = true,
    this.gender = GenderType.male,
    this.isCheckedNotificationCheckbox = false,
    this.isCheckedNotifictaionAboutApplication = false,
    this.passwordErrorText,
    this.showError = false,
    this.confirmPhoneCode,
    this.installedPhone,
  });

  PersonalDataScreenState copyWith({
    bool? isLoading,
    bool? isButtonActive,
    GenderType? gender,
    bool? isCheckedNotificationCheckbox,
    bool? isCheckedPolicyCheckbox,
    String? passwordErrorText,
    bool? showError,
    String? confirmPhoneCode,
    String? installedPhone,
  }) {
    return PersonalDataScreenState(
      isLoading: isLoading ?? this.isLoading,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      gender: gender ?? this.gender,
      isCheckedNotificationCheckbox:
          isCheckedNotificationCheckbox ?? this.isCheckedNotificationCheckbox,
      isCheckedNotifictaionAboutApplication:
          isCheckedPolicyCheckbox ?? this.isCheckedNotifictaionAboutApplication,
      passwordErrorText: passwordErrorText,
      showError: showError ?? this.showError,
      confirmPhoneCode: confirmPhoneCode,
      installedPhone: installedPhone ?? this.installedPhone,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isButtonActive,
        gender,
        isCheckedNotificationCheckbox,
        isCheckedNotifictaionAboutApplication,
        passwordErrorText,
        showError,
        confirmPhoneCode,
        installedPhone
      ];
}

class PersonalDataScreenLoadingState extends PersonalDataScreenState {}

class DeleteAccountState extends PersonalDataScreenState {}
