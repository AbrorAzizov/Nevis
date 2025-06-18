import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/products_screen/product_widget.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: getMarginOrPadding(
          bottom: 70,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: getMarginOrPadding(left: 20),
              child: Text('Корзина', style: UiConstants.textStyle17),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: getMarginOrPadding(left: 20),
              child: Text(
                'В корзине пока нет товаров',
                style: UiConstants.textStyle11.copyWith(
                  color: UiConstants.black3Color.withOpacity(.6),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Center(child: Image.asset(Paths.emptyProductsCartIconPath)),
            SizedBox(height: 9.h),
            Padding(
              padding: getMarginOrPadding(left: 20, right: 20),
              child: AppButtonWidget(
                  onTap: () =>
                      context.read<HomeScreenBloc>().add(ChangePageEvent(1)),
                  text: 'В каталог'),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: getMarginOrPadding(left: 20),
              child: Text(
                'Рекомендуемые товары',
                style: UiConstants.textStyle5
                    .copyWith(color: UiConstants.black2Color),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 390.h,
              child: ListView.builder(
                  padding: getMarginOrPadding(left: 20, right: 20),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount:
                      context.read<CartScreenBloc>().state.products.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                        product: context
                            .read<CartScreenBloc>()
                            .state
                            .products[index],
                        isSelected: false,
                        showCheckbox: false);
                  }),
            ),
            SizedBox(height: 16.h)
          ],
        ),
      ),
    );
  }
}
