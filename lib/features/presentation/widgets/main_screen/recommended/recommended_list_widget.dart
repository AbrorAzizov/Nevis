import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/catalog/products/products_screen.dart';
import 'package:nevis/features/presentation/widgets/main_screen/recommended/recommended_item_widget.dart';

class RecommendedListWidget extends StatelessWidget {
  const RecommendedListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.w,
      child: ListView.separated(
          padding: getMarginOrPadding(left: 20, right: 20),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => RecommendedItemWidget(
                onTap: () {
                  final homeBloc = context.read<HomeScreenBloc>();
                  homeBloc.add(ChangePageEvent(1));
                  Navigator.of(homeBloc.navigatorKeys[1].currentContext!).push(
                    Routes.createRoute(
                      ProductsScreen(),
                      settings: RouteSettings(
                        name: Routes.productsScreen,
                        arguments: {'title': 'Лекарства и БАДЫ', 'id': '9475'},
                      ),
                    ),
                  );
                },
              ),
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemCount: 10),
    );
  }
}
