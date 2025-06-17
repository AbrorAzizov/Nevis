import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/data/models/loyalty_card_register_model.dart';
import 'package:nevis/features/domain/usecases/loyalty_card/register_card.dart';
import 'package:nevis/features/domain/usecases/profile/get_me.dart';

part 'register_bonus_card_screen_event.dart';
part 'register_bonus_card_screen_state.dart';

class RegisterBonusCardScreenBloc
    extends Bloc<RegisterBonusCardScreenEvent, RegisterBonusCardScreenState> {
  BuildContext? screenContext;
  BonusCardType? cardType;

  final GetMeUC getMeUC;
  final RegisterCardUC registerCardUC;

  TextEditingController fNameController = TextEditingController();
  TextEditingController sNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cardController = TextEditingController();

  RegisterBonusCardScreenBloc(
      {required this.getMeUC,
      required this.registerCardUC,
      this.cardType,
      BuildContext? context})
      : super(RegisterBonusCardScreenState()) {
    screenContext = context;

    on<ChangeBirthdayEvent>(
      (event, emit) {
        emit(state.copyWith(birthday: event.date));
        validateFields();
      },
    );

    on<ChangeGenderEvent>(
      (event, emit) {
        emit(
          state.copyWith(gender: event.gender),
        );
      },
    );

    on<SubmitEvent>(_onSubmit);

    fNameController.addListener(validateFields);
    sNameController.addListener(validateFields);
    phoneController.addListener(validateFields);
    emailController.addListener(validateFields);
    cardType == BonusCardType.physical
        ? cardController.addListener(validateFields)
        : null;
  }

  Future getProfile() async {
    final failureOrLoads = await getMeUC();

    return failureOrLoads.fold(
      (_) => Utils.showCustomDialog(
        screenContext: screenContext!,
        text: 'Неизвестная ошибка',
        action: (context) {
          Navigator.of(context).pop();
          Navigator.of(screenContext!).pop();
        },
      ),
      (profile) {
        cardController.text = profile.card ?? '';
        fNameController.text = profile.firstName ?? '';
        sNameController.text = profile.lastName ?? '';
        phoneController.text = Utils.formatPhoneNumber(profile.phone,
            format: PhoneNumberFormat.client);
        emailController.text = profile.email ?? '';
        emit(
          RegisterBonusCardScreenState(
            isLoading: false,
            gender: GenderType.values
                    .firstWhereOrNull((e) => e.name == profile.gender) ??
                GenderType.values.first,
            birthday: profile.dateOfBirth != null
                ? Utils.parseCustomDate(profile.dateOfBirth!)
                : null,
          ),
        );
      },
    );
  }

  void validateFields() {
    bool isCardRequired = cardType == BonusCardType.physical;
    bool isAllFieldsFilled = fNameController.text.isNotEmpty &&
        sNameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        Utils.phoneValidate(phoneController.text) == null &&
        Utils.emailValidate(emailController.text) == null &&
        state.birthday != null &&
        (!isCardRequired || cardController.text.length == 13);

    emit(state.copyWith(isButtonActive: isAllFieldsFilled));
  }

  void _onSubmit(
      SubmitEvent event, Emitter<RegisterBonusCardScreenState> emit) async {
    final failureOrLoads = await registerCardUC(
      LoyaltyCardRegisterModel(
          cardNumber: cardController.text,
          phoneNumber: Utils.formatPhoneNumber(phoneController.text,
              format: PhoneNumberFormat.loyaltyCard),
          birthDate: DateFormat('yyyy-MM-dd').format(state.birthday!),
          gender: state.gender == GenderType.F ? 'Ж' : 'М',
          firstName: fNameController.text,
          lastName: sNameController.text,
          email: emailController.text),
    );

    failureOrLoads.fold(
      (e) => Utils.showCustomDialog(
        screenContext: screenContext!,
        text: e.message.toString(),
        action: (context) {
          Navigator.of(context).pop();
        },
      ),
      (_) {
        emit(SuccessRegistration(loyalCardType: cardType!));
      },
    );
  }

  @override
  Future<void> close() {
    fNameController.dispose();
    sNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    cardController.dispose();
    return super.close();
  }
}
