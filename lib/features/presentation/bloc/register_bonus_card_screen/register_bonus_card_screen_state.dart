part of 'register_bonus_card_screen_bloc.dart';

class RegisterBonusCardScreenState extends Equatable {
  final bool isLoading;
  final bool isButtonActive;
  final GenderType? gender;
  final DateTime? birthday;

  const RegisterBonusCardScreenState({
    this.isLoading = true,
    this.isButtonActive = false,
    this.gender = GenderType.M,
    this.birthday,
  });

  RegisterBonusCardScreenState copyWith({
    bool? isLoading,
    bool? isButtonActive,
    GenderType? gender,
    DateTime? birthday,
  }) {
    return RegisterBonusCardScreenState(
      isLoading: isLoading ?? this.isLoading,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isButtonActive,
        gender,
        birthday,
      ];
}

class SuccessRegistration extends RegisterBonusCardScreenState {
  final BonusCardType loyalCardType;
  const SuccessRegistration({required this.loyalCardType});
}
