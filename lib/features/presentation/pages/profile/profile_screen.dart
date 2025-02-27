import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/profile_screen/profile_categories_list.dart';
import 'package:nevis/locator_service.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        HomeScreenBloc homeBloc = context.read<HomeScreenBloc>();
        return BlocProvider(
          create: (context) => ProfileScreenBloc(
            logoutUC: sl(),
          ),
          child: BlocConsumer<ProfileScreenBloc, ProfileScreenState>(
            listener: (context, state) => switch (state) {
              NavigateLoginState _ =>
                Navigator.of(homeBloc.context).pushAndRemoveUntil(
                    Routes.createRoute(
                      const LoginScreen(),
                      settings: RouteSettings(
                        name: Routes.loginScreen,
                        arguments: {'redirect_type': LoginScreenType.login},
                      ),
                    ),
                    (_) => false),
              ProfileScreenState() => throw UnimplementedError(),
            },
            builder: (context, state) {
              final bloc = context.read<ProfileScreenBloc>();
              return Scaffold(
                backgroundColor: UiConstants.backgroundColor,
                body: SafeArea(
                  child: Builder(
                    builder: (context) {
                      return Column(
                        children: [
                          CustomAppBar(
                            backgroundColor: UiConstants.backgroundColor,
                            title: 'Профиль',
                            action: GestureDetector(
                              onTap: () => bloc.add(LogoutEvent()),
                              child: SvgPicture.asset(Paths.exitIconPath,
                                  height: 24.w, width: 24.w),
                            ),
                          ),
                          Expanded(
                            child: homeState is InternetUnavailable
                                ? InternetNoInternetConnectionWidget()
                                : ListView(
                                    shrinkWrap: true,
                                    padding: getMarginOrPadding(
                                        bottom: 94,
                                        right: 20,
                                        left: 20,
                                        top: 16),
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
      },
    );
  }
}
