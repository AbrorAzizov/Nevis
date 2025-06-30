import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/bottom_sheet_manager.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_phone_call.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/personal_data_screen/checkboxed_block.dart';
import 'package:nevis/features/presentation/widgets/personal_data_screen/general_information_block.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PersonalDataScreen extends StatelessWidget {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) => PersonalDataScreenBloc(
              context: context.read<HomeScreenBloc>().context,
              getMeUC: sl(),
              updateMeUC: sl(),
              deleteMeUC: sl())
            ..add(LoadProfileEvent(context: context)),
          child: BlocConsumer<PersonalDataScreenBloc, PersonalDataScreenState>(
            listener: (context, state) => switch (state) {
              DeleteAccountState _ =>
                Navigator.of(context.read<HomeScreenBloc>().context!)
                    .pushAndRemoveUntil(
                        Routes.createRoute(
                          const LoginScreenWithPhoneCall(
                            canBack: true,
                          ),
                          settings: RouteSettings(
                            name: Routes.loginScreenPhoneCall,
                            arguments: {'redirect_type': LoginScreenType.login},
                          ),
                        ),
                        (_) => false),
              _ => {},
            },
            builder: (context, state) {
              final personalDataBloc = context.read<PersonalDataScreenBloc>();
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Skeletonizer(
                    ignorePointers: false,
                    enabled: state.isLoading,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            CustomAppBar(
                                backgroundColor: UiConstants.backgroundColor,
                                title: 'Личные данные',
                                showBack: true),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                padding: getMarginOrPadding(
                                    bottom: 94, right: 20, left: 20, top: 16),
                                children: [
                                  GeneralInformationBlock(
                                      screenContext: context),
                                  SizedBox(height: 16.h),
                                  CheckboxesBlock(screenContext: context),
                                  SizedBox(height: 32.h),
                                  AppButtonWidget(
                                    isActive: state.isButtonActive,
                                    text: 'Сохранить',
                                    onTap: () {
                                      personalDataBloc.add(
                                        SubmitEvent(context: context),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 8.h),
                                  AppButtonWidget(
                                      text: 'Удалить аккаунт',
                                      backgroundColor:
                                          UiConstants.backgroundColor,
                                      textColor: UiConstants.black3Color
                                          .withOpacity(.6),
                                      fontWeight: FontWeight.w400,
                                      onTap: () async {
                                        bool? isAgree = await BottomSheetManager
                                            .showDeleteAccountSheet(context);

                                        if (isAgree == true) {
                                          personalDataBloc.add(
                                              DeleteAccountEvent(
                                                  context: context));
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
