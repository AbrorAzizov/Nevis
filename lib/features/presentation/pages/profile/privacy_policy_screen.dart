import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/docs_and_instructions/docs_and_instructions_categories_list.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/privacy_policy_screen/booking_rules_widget.dart';
import 'package:nevis/features/presentation/widgets/privacy_policy_screen/card_payment_rules.widget.dart';
import 'package:nevis/features/presentation/widgets/privacy_policy_screen/deliviry_rules_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return Scaffold(
          backgroundColor: UiConstants.whiteColor,
          body: SafeArea(
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    CustomAppBar(
                      backgroundColor: UiConstants.whiteColor,
                      title: ' Политика обработки\nперсональных данных',
                      showBack: true,
                    ),
                    Expanded(
                      child: homeState is InternetUnavailable
                          ? InternetNoInternetConnectionWidget()
                          : SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            
                              padding: getMarginOrPadding(
                                  bottom: 65, right: 20, left: 20, top: 16),
                              child: Column(
                                children: [
                                  BookingRules(),
                                  DeliviryRules(),
                                  CardPaymentRules()
                                ],
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
