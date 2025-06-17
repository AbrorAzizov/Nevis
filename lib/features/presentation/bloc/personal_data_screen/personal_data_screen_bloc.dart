import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/features/data/models/profile_model.dart';
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

  TextEditingController fNameController = TextEditingController(text: '');
  TextEditingController sNameController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');

  PersonalDataScreenBloc(
      {required this.getMeUC,
      required this.updateMeUC,
      required this.deleteMeUC,
      BuildContext? context})
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

    on<ChangeBirthdayEvent>(
      (event, emit) {
        emit(
          state.copyWith(birthday: event.date),
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

    on<SubmitEvent>(
      (event, emit) async {
        final failureOrLoads = await updateMeUC(ProfileModel(
          firstName: fNameController.text,
          lastName: sNameController.text,
          email: emailController.text,
          gender: GenderType.values.firstWhere((e) => e == state.gender).name,
          subscribeToMarketing: state.isCheckedNotificationCheckbox,
          dateOfBirth: DateFormat('dd.MM.yyyy').format(state.birthday!),
        ));
        failureOrLoads.fold((_) => emit(state.copyWith(showError: true)),
            (_) async {
          emit(state.copyWith(isLoading: true));
          add(LoadDataEvent());
        });
      },
    );

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

    on<LoadDataEvent>((event, emit) async {
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

          phoneController.text = Utils.formatPhoneNumber(profile.phone,
              format: PhoneNumberFormat.client);
          emailController.text = profile.email ?? '';
          emit(
            PersonalDataScreenState(
                isLoading: false,
                gender: GenderType.values
                        .firstWhereOrNull((e) => e.name == profile.gender) ??
                    GenderType.values.first,
                birthday: profile.dateOfBirth != null
                    ? Utils.parseCustomDate(profile.dateOfBirth!)
                    : null,
                isCheckedNotificationCheckbox:
                    profile.subscribeToMarketing ?? false),
          );
        },
      );
    });
  }

  @override
  Future<void> close() {
    fNameController.dispose();
    sNameController.dispose();
    phoneController.dispose();
    emailController.dispose();

    return super.close();
  }
}
