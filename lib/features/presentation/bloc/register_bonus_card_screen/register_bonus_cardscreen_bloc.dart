import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/usecases/profile/get_me.dart';

part 'register_bonus_card_screen_event.dart';
part 'register_bonus_card_screen_screen_state.dart';

class RegisterBonusCardScreenBloc
    extends Bloc<RegisterBonusCardScreenEvent, RegisterBonusCardScreenState> {
  BuildContext? screenContext;
  final BonusCardType cardType;

  final GetMeUC getMeUC;
  TextEditingController fNameController = TextEditingController();
  TextEditingController sNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cardController = TextEditingController();

  RegisterBonusCardScreenBloc(
      {required this.getMeUC, required this.cardType, BuildContext? context})
      : super(PersonalDataScreenLoadingState()) {
    screenContext = context;

    on<ChangeNotificationCheckboxEvent>(
      (event, emit) {
        emit(
          state.copyWith(
              isCheckedNotificationCheckbox:
                  event.isCheckedNotificationCheckbox),
        );
      },
    );

    on<ChangePolicyCheckboxEvent>(
      (event, emit) {
        emit(
          state.copyWith(
              isCheckedPolicyCheckbox: event.isCheckedPolicyCheckbox),
        );
      },
    );

    on<ChangeGenderEvent>(
      (event, emit) {
        emit(
          state.copyWith(gender: event.gender),
        );
      },
    );

    on<ConfirmPhoneChangeEvent>(
      (event, emit) {
        emit(
          state.copyWith(confirmPhoneCode: event.confirmPhoneCode),
        );
      },
    );
    fNameController.addListener(validateFields);
    sNameController.addListener(validateFields);
    phoneController.addListener(validateFields);
    emailController.addListener(validateFields);
    cardType == BonusCardType.physical
        ? cardController.addListener(validateFields)
        : null;
  }
  // on<SubmitEvent>(
  //   (event, emit) async {
  //     final isValidPhone = Utils.phoneRegexp.hasMatch(phoneController.text);
  //     if (state.installedPhone != phoneController.text && isValidPhone) {
  //       Utils.showCustomDialog(
  //         screenContext: screenContext!,
  //         text: 'Номер телефона не подтверждён',
  //         action: (context) {
  //           Navigator.of(context).pop();
  //         },
  //       );
  //     } else {
  //       await updateProfile();
  //     }
  //   },
  // );

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
        birthdayController.text = profile.dateOfBirth != null
            ? profile.dateOfBirth!.replaceAll('.', ' / ')
            : '';
        phoneController.text =
            Utils.formatPhoneNumber(profile.phone, toServerFormat: false);
        emailController.text = profile.phone ?? '';
        emit(
          RegisterBonusCardScreenState(
            isLoading: false,
            gender: GenderType.values
                    .firstWhereOrNull((e) => e.name == profile.gender) ??
                GenderType.values.first,
            installedPhone:
                Utils.formatPhoneNumber(profile.phone, toServerFormat: false),
          ),
        );
      },
    );
  }

  // Future<String?> updateProfile(
  //     {bool requestedCode = false, String? confirmedCode}) async {
  //   final failureOrLoads = await updateMeUC(
  //     ProfileModel(
  //         firstName: fNameController.text,
  //         lastName: sNameController.text,
  //         phone: Utils.formatPhoneNumber(phoneController.text),
  //         gender: GenderType.values.firstWhere((e) => e == state.gender).name,
  //         dateOfBirth: birthdayController.text.replaceAll(' / ', '.'),
  //         email: emailController.text,
  //         acceptPolicy: state.isCheckedPolicyCheckbox ? "1" : "0",
  //         statusNotifications: state.isCheckedNotificationCheckbox ? "1" : "0",
  //         code: confirmedCode,
  //         oldPassword: oldPasswordController.text,
  //         newPassword: newPasswordController.text,
  //         newPasswordConfirm: newPasswordConfirmController.text),
  //   );

  //   return failureOrLoads.fold(
  //     (failure) {
  //       String error = switch (failure) {
  //         SendingCodeTooOftenFailure _ =>
  //           'Слишком частая отправка кода или превышено число попыток за день',
  //         AcceptPersonalDataFailure _ =>
  //           'Примите условия политики обработки персональных данных',
  //         _ => 'Ошибка обновления данных'
  //       };
  //       if (!requestedCode) {
  //         Utils.showCustomDialog(
  //           screenContext: screenContext!,
  //           text: error,
  //           action: (context) {
  //             Navigator.of(context).pop();
  //           },
  //         );
  //       }
  //       return error;
  //     },
  //     (code) async {
  //       if (!requestedCode) {
  //         if (confirmedCode != null) {
  //           Navigator.of(screenContext!).pop();
  //         }
  //         await getProfile();
  //         Utils.showCustomDialog(
  //           screenContext: screenContext!,
  //           title: 'Уведомление',
  //           text: 'Данные обновлены',
  //           action: (context) {
  //             Navigator.of(context).pop();
  //           },
  //         );
  //       }

  //       return code;
  //     },
  //   );
  // }

  @override
  Future<void> close() {
    fNameController.dispose();
    sNameController.dispose();
    birthdayController.dispose();
    phoneController.dispose();
    emailController.dispose();
    cardController.dispose();
    return super.close();
  }

  void validateFields() {
    bool isCardRequired = cardType == BonusCardType.physical;
    bool isAllFieldsFilled = fNameController.text.isNotEmpty &&
        sNameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        (!isCardRequired || cardController.text.isNotEmpty);

    emit(state.copyWith(isButtonActive: isAllFieldsFilled));
  }
}
