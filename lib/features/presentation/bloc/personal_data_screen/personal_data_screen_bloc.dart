import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/domain/usecases/profile/delete_me.dart';
import 'package:nevis/features/domain/usecases/profile/get_me.dart';
import 'package:nevis/features/domain/usecases/profile/update_me.dart';

part 'personal_data_screen_event.dart';
part 'personal_data_screen_state.dart';

class PersonalDataScreenBloc
    extends Bloc<PersonalDataScreenEvent, PersonalDataScreenState> {
  BuildContext? screenContext;

  final GetMeUC getMeUC;
  final UpdateMeUC updateMeUC;
  final DeleteMeUC deleteMeUC;

  TextEditingController fNameController =
      TextEditingController(text: 'Константин');
  TextEditingController sNameController = TextEditingController(text: 'Усиков');
  TextEditingController birthdayController = TextEditingController();
  TextEditingController phoneController =
      TextEditingController(text: '7 800 555-35-35');
  TextEditingController emailController =
      TextEditingController(text: 'example@mail.ru');

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmController = TextEditingController();

  PersonalDataScreenBloc(
      {required this.getMeUC,
      required this.updateMeUC,
      required this.deleteMeUC,
      BuildContext? context})
      : super(PersonalDataScreenLoadingState()) {
    screenContext = context;
    oldPasswordController.addListener(() {
      add(PasswordChangedEvent());
    });

    newPasswordController.addListener(() {
      add(PasswordChangedEvent());
    });

    newPasswordConfirmController.addListener(() {
      add(PasswordChangedEvent());
    });

    on<PasswordChangedEvent>((event, emit) {
      if (oldPasswordController.text.isEmpty &&
          newPasswordController.text.isEmpty &&
          newPasswordConfirmController.text.isEmpty) {
        emit(
          state.copyWith(
              isButtonActive: true, passwordErrorText: null, showError: false),
        );
      } else if (oldPasswordController.text.isEmpty &&
              [newPasswordController.text, newPasswordConfirmController.text]
                  .any((e) => e.isNotEmpty) ||
          oldPasswordController.text.isNotEmpty &&
              [newPasswordController.text, newPasswordConfirmController.text]
                  .any((e) => e.isEmpty)) {
        emit(
          state.copyWith(
              isButtonActive: false,
              passwordErrorText: 'Поле должно быть заполнено',
              showError: true),
        );
      } else if (newPasswordController.text !=
          newPasswordConfirmController.text) {
        emit(
          state.copyWith(
              isButtonActive: false,
              passwordErrorText: 'Пароли не совпадают',
              showError: true),
        );
      } else {
        emit(
          state.copyWith(
              isButtonActive: true, passwordErrorText: null, showError: false),
        );
      }
    });

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

    on<DeleteAccountEvent>(
      (event, emit) async {
        final failureOrLoads = await deleteMeUC();

        return failureOrLoads.fold(
          (_) => Utils.showCustomDialog(
            screenContext: screenContext!,
            text: 'Неизвестная ошибка',
            action: (context) {
              Navigator.of(context).pop();
            },
          ),
          (_) => emit(DeleteAccountState()),
        );
      },
    );
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
        fNameController.text = profile.firstName ?? '';
        sNameController.text = profile.lastName ?? '';
        birthdayController.text = profile.dateOfBirth != null
            ? profile.dateOfBirth!.replaceAll('.', ' / ')
            : '';
        phoneController.text =
            Utils.formatPhoneNumber(profile.phone, toServerFormat: false);
        emailController.text = profile.phone ?? '';
        emit(
          PersonalDataScreenState(
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
    oldPasswordController.dispose();
    newPasswordController.dispose();
    newPasswordConfirmController.dispose();

    oldPasswordController.removeListener(() {
      add(PasswordChangedEvent());
    });
    newPasswordController.removeListener(() {
      add(PasswordChangedEvent());
    });

    return super.close();
  }
}
