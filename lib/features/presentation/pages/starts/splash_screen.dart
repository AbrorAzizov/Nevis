import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/home_screen.dart';
import 'package:nevis/features/presentation/pages/starts/login_screen_with_phone_call.dart';
import 'package:nevis/locator_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLogoVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLogoVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(Paths.logoIconPath), context);
    ImageProvider logo = AssetImage(Paths.logoIconPath);

    return BlocProvider(
      create: (_) => SplashScreenBloc(
        sharedPreferences: sl(),
        getMeUC: sl(),
      )..add(SplashScreenStarted()),
      child: BlocListener<SplashScreenBloc, SplashScreenState>(
        listener: (context, state) {
          if (state is SplashScreenNavigateLogin) {
            Navigator.of(context).pushReplacement(
              Routes.createRoute(
                const LoginScreenWithPhoneCall(),
                settings: RouteSettings(
                  name: Routes.loginScreenPhoneCall,
                  arguments: {'redirect_type': LoginScreenType.login},
                ),
              ),
            );
          } else if (state is SplashScreenNavigateHome) {
            Navigator.of(context).pushReplacement(
              Routes.createRoute(
                const HomeScreen(),
                settings: RouteSettings(name: Routes.homeScreen),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
          ),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  UiConstants.gradientFirstColor,
                  UiConstants.gradientSecondColor,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _isLogoVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Image(
                    image: logo,
                    width: 136,
                    height: 136,
                  ),
                ),
                const SizedBox(height: 16),
               Row(
                      children: [
                        Expanded(child: Text('АПТЕКА НЕВИС',style: UiConstants.splashTextStyle,textAlign: TextAlign.center,)),
                      ],
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



 