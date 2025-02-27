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
import 'package:nevis/features/presentation/pages/starts/login_screen.dart';
import 'package:nevis/locator_service.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const LoginScreen(),
                settings: RouteSettings(
                  name: Routes.loginScreen,
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
              surfaceTintColor: Colors.transparent),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft, 
                end: Alignment.bottomRight, 
                colors: 
                [
                  UiConstants.gradientFirstColor,
                  UiConstants.gradientSecondColor 
                ]
              )
            ),
            child: 
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Paths.logoIconPath, 
                    width: 136,
                    height: 136,
                  ),
                  SizedBox(height: 16,),
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
