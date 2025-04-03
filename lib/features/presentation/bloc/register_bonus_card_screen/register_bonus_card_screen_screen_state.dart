part of 'register_bonus_cardscreen_bloc.dart';

class RegisterBonusCardScreenState extends Equatable {
  final bool isLoading;
  final bool isButtonActive;
  final GenderType? gender;
  final bool isCheckedNotificationCheckbox;
  final bool isCheckedPolicyCheckbox;
  final bool showError;
  final String? confirmPhoneCode;
  final String? installedPhone;

  const RegisterBonusCardScreenState({
    this.isLoading = true,
    this.isButtonActive = false,
    this.gender = GenderType.male,
    this.isCheckedNotificationCheckbox = false,
    this.isCheckedPolicyCheckbox = false,
    this.showError = false,
    this.confirmPhoneCode,
    this.installedPhone,
  });

  RegisterBonusCardScreenState copyWith({
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
    return RegisterBonusCardScreenState(
      isLoading: isLoading ?? this.isLoading,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      gender: gender ?? this.gender,
      isCheckedNotificationCheckbox:
          isCheckedNotificationCheckbox ?? this.isCheckedNotificationCheckbox,
      isCheckedPolicyCheckbox:
          isCheckedPolicyCheckbox ?? this.isCheckedPolicyCheckbox,
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
        isCheckedPolicyCheckbox,
        showError,
        confirmPhoneCode,
        installedPhone
      ];
}

class PersonalDataScreenLoadingState extends RegisterBonusCardScreenState {}

class DeleteAccountState extends RegisterBonusCardScreenState {}
