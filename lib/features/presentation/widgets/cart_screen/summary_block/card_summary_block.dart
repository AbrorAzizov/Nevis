import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/bottom_sheet_manager.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/summary_block/promo_code_plate_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/summary_block/summary_prices_block.dart';

class CardSummaryBlock extends StatelessWidget {
  const CardSummaryBlock(
      {super.key, this.screenContext, required this.canUsePromoCodes});

  final BuildContext? screenContext;

  final bool canUsePromoCodes;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      bloc: screenContext?.read<HomeScreenBloc>(),
      buildWhen: (previous, current) => screenContext == null,
      builder: (context, state) {
        final homeBloc = (screenContext ?? context).read<HomeScreenBloc>();

        return BlocBuilder<CartScreenBloc, CartScreenState>(
          bloc: screenContext?.read<CartScreenBloc>(),
          buildWhen: (previous, current) => screenContext == null,
          builder: (context, state) {
            final cartBloc = (screenContext ?? context).read<CartScreenBloc>();

            return Container(
              padding:
                  getMarginOrPadding(left: 16, right: 16, top: 16, bottom: 32),
              decoration: BoxDecoration(
                color: UiConstants.whiteColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  if (canUsePromoCodes)
                    AppTextFieldWidget(
                      title: 'Промокод',
                      hintText: 'Введите промокод',
                      controller: controller,
                      hintMaxLines: 1,
                      suffixPadding: getMarginOrPadding(left: 16, right: 4),
                      suffixWidget: Padding(
                        padding: getMarginOrPadding(top: 4, bottom: 4),
                        child: AppButtonWidget(
                          isActive: true,
                          text: 'Добавить',
                          borderRadius: 12.r,
                          isExpanded: false,
                          onTap: () {
                            if (controller.text.isNotEmpty) {
                              cartBloc.add(AddPromoCodeEvent());
                              controller.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  if (state.promoCodes.isNotEmpty && canUsePromoCodes)
                    SizedBox(height: 24.h),
                  // список промокодов
                  if (canUsePromoCodes)
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => PromoCodePlateWidget(
                              onDelete: () =>
                                  BottomSheetManager.showDeletePromoCodeSheet(
                                      homeBloc.context),
                            ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 4.h),
                        itemCount: state.promoCodes.length),
                  if (canUsePromoCodes) SizedBox(height: 24.h),
                  SummaryPricesBlock(cartType: cartBloc.state.cartType),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
