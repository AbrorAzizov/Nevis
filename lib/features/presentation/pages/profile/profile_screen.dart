import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/presentation/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/profile_screen/profile_screen_state.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/profile_screen/profile_categories_list.dart';
import 'package:nevis/locator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = sl<SharedPreferences>();

    return BlocProvider(
      create: (context) => ProfileScreenBloc(
        logoutUC: sl(),
      ),
      child: BlocConsumer<ProfileScreenBloc, ProfileScreenState>(
        listener: (context, state) async {
          if (state is SuccessfullyQuitedFromProfileState) {
            await prefs.remove(SharedPreferencesKeys.accessToken);
            await prefs.remove(SharedPreferencesKeys.refreshToken);
          }
        },
        builder: (context, state) {
          final bloc = context.read<ProfileScreenBloc>();
          return Scaffold(
            backgroundColor: UiConstants.whiteColor,
            body: SafeArea(
              child: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      CustomAppBar(
                          backgroundColor: UiConstants.whiteColor,
                          title: 'Профиль',
                          action: prefs.getString(
                                      SharedPreferencesKeys.accessToken) !=
                                  null
                              ? GestureDetector(
                                  onTap: () {
                                    bloc.add(LogoutEvent());
                                  },
                                  child: SvgPicture.asset(
                                    Paths.exitIconPath,
                                    height: 24.w,
                                    width: 24.w,
                                  ),
                                )
                              : null),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: getMarginOrPadding(
                            bottom: 94,
                            right: 20,
                            left: 20,
                            top: 16,
                          ),
                          children: [
                            ProfileCategoriesList(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
