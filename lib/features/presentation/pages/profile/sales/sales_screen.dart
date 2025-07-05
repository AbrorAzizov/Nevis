import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/sales_screen/sales_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/sales_screen/sales_list_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../locator_service.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, homeState) {
        return BlocProvider(
          create: (context) =>
              SalesScreenBloc(getPromotionsUC: sl())..add(GetPromotionsEvent()),
          child: Builder(
            builder: (context) {
              scrollController.addListener(
                () {
                  if (scrollController.position.pixels ==
                      scrollController.position.maxScrollExtent) {
                    context
                        .read<SalesScreenBloc>()
                        .add(GetPromotionsEventFromNextPage());
                  }
                },
              );
              return BlocBuilder<SalesScreenBloc, SalesScreenState>(
                builder: (context, state) {
                  return Scaffold(
                    backgroundColor: UiConstants.backgroundColor,
                    body: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomAppBar(
                            title: 'Акции',
                            showBack: true,
                            action: SvgPicture.asset(Paths.shareIconPath),
                          ),
                          state.isLoading ? Center(child: CircularProgressIndicator(),) : Expanded(
                            child: SalesListWidget(
                              promotions: state.promotions,
                              scrollController: scrollController,
                            ),
                          ),
                          if (state.isLoadingFromNextPage == true) Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 80),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
