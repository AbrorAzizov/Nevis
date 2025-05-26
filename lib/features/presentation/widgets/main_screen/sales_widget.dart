import 'package:flutter/material.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/pages/profile/sales/sales_screen.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget2.dart';
import 'package:nevis/features/presentation/widgets/sales_screen/sales_horizontal_list_widget.dart';

class SalesWidget extends StatelessWidget {
  const SalesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlockWidget2(
      title: 'Акции',
      titlePadding: getMarginOrPadding(left: 20, right: 20),
      onTapAll: () {
        Navigator.of(context).push(
          Routes.createRoute(
            SalesScreen(),
            settings: RouteSettings(name: Routes.salesScreen),
          ),
        );
      },
      child: SalesHorizontalListWidget(),
    );
  }
}
