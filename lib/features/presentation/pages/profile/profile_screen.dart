import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/profile_screen/profile_screen_state.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_phone_call.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/profile_screen/profile_categories_list.dart';
import 'package:nevis/locator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = sl<SharedPreferences>();
    final accessToken = prefs.getString(SharedPreferencesKeys.accessToken);
    if (accessToken == null || accessToken.isEmpty) {
      Future.microtask(() {
        Navigator.of(context).pushReplacement(
          Routes.createRoute(
            const LoginScreenWithPhoneCall(
              canBack: false,
            ),
            settings: RouteSettings(
              name: Routes.loginScreenPhoneCall,
              arguments: {
                'redirect_type': LoginScreenType.logInWithCalls,
              },
            ),
          ),
        );
      });

      // Пока навигатор переключается, можно отдать пустой экран
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Если токен есть, отображаем обычный профиль
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        bool canQuit = true;

        return BlocProvider(
          create: (context) => ProfileScreenBloc(
            logoutUC: sl(),
          ),
          child: BlocConsumer<ProfileScreenBloc, ProfileScreenState>(
            listener: (context, state) async {
              if (state is SuccessfullyQuitedFromProfileState) {
                await prefs.remove(SharedPreferencesKeys.accessToken);
              }
            },
            builder: (context, state) {
              final bloc = context.read<ProfileScreenBloc>();
              return Scaffold(
                backgroundColor: UiConstants.whiteColor,
                body: SafeArea(
                  child: Column(
                    children: [
                      CustomAppBar(
                        backgroundColor: UiConstants.whiteColor,
                        title: 'Профиль',
                        action: canQuit
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
                            : SizedBox.shrink(),
                      ),
                      Expanded(
                        child: homeState is InternetUnavailable
                            ? InternetNoInternetConnectionWidget()
                            : ListView(
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
