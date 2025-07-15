import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/firebase_manager.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/order_delivery_personal_data_screen/order_delivery_personal_data_bloc.dart';
import 'package:nevis/features/presentation/pages/order/order_pickup_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/custom_bottom_sheet.dart';
import 'package:nevis/locator_service.dart';

class BottomSheetManager {
  static showClearCartSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return CustomBottomSheet(
          height: 228.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Вы дейстивильно хотите очистить корзину?',
                style: UiConstants.textStyle5
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: AppButtonWidget(
                      alignment: Alignment.centerLeft,
                      onTap: () {
                        Navigator.pop(sheetContext);
                        context.read<CartScreenBloc>().add(ClearCartEvent());
                      },
                      text: 'Очистить',
                      backgroundColor: UiConstants.whiteColor,
                      textColor: UiConstants.black3Color.withOpacity(.6),
                    ),
                  ),
                  Expanded(
                    child: AppButtonWidget(
                        onTap: () => Navigator.pop(sheetContext),
                        text: 'Нет',
                        backgroundColor: UiConstants.blueColor),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static showNotAllProductsAvailableDeliverySheet(
      BuildContext screenContext, BuildContext homeContext) {
    return showModalBottomSheet(
      context: homeContext,
      builder: (sheetContext) {
        return CustomBottomSheet(
          height: 288.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Не все товары доступны для доставки',
                style: UiConstants.textStyle5
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
              SizedBox(height: 8.h),
              Text(
                'Чтобы продолжить, снимите выбор с недоступных для доставки товаров или измените способ получения на самовывоз.',
                style: UiConstants.textStyle3.copyWith(
                  color: UiConstants.darkBlue2Color.withOpacity(.6),
                ),
              ),
              SizedBox(height: 16.h),
              AppButtonWidget(
                text: 'Оформить самовывоз',
                onTap: () {
                  // homeContext.read<CartScreenBloc>().add(
                  //       ChangeCartTypeEvent(TypeReceiving.pickup),
                  //     );
                  // homeContext.read<CartScreenBloc>().add(
                  //       ScrollUpListEvent(),
                  //     );
                  // screenContext.read<SelectorCubit>().onSelectorItemTap(
                  //       [TypeReceiving.delivery, TypeReceiving.pickup]
                  //           .indexOf(TypeReceiving.pickup),
                  //     );
                  // Navigator.pop(sheetContext);
                },
              ),
              SizedBox(height: 8.h),
              AppButtonWidget(
                text: 'Вернуться к оформлению',
                isFilled: false,
                onTap: () => Navigator.pop(sheetContext),
              ),
            ],
          ),
        );
      },
    );
  }

  static showWarningAboutNonDeliveryProduct(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return CustomBottomSheet(
          height: 283.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'В вашей корзине недоступные для доставки товары.\nЗаказ будет оформлен без них.',
                style: UiConstants.textStyle5
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
              SizedBox(height: 16.h),
              AppButtonWidget(
                text: 'Продолжить оформление',
                onTap: () {
                  final bool unavailableForDeliviry = context
                      .read<CartScreenBloc>()
                      .state
                      .cartProducts
                      .any((p) => p.availableForDelivery == false);
                  if (unavailableForDeliviry) {
                    Navigator.pop(sheetContext);
                    Navigator.of(context).push(
                      Routes.createRoute(
                        const OrderPickupScreen(),
                        settings: RouteSettings(
                          name: Routes.orderPickupScreen,
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 8.h),
              AppButtonWidget(
                textColor: UiConstants.black3Color.withOpacity(.6),
                text: 'Редактировать корзину',
                isFilled: false,
                onTap: () {
                  Navigator.pop(sheetContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool?> showEnableNotificationSheet(BuildContext context) {
    return showModalBottomSheet<bool?>(
      useRootNavigator: true,
      context: context,
      builder: (sheetContext) {
        return CustomBottomSheet(
          height: 158.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Хотите получать Push-уведомления о статусе заказа?',
                style: UiConstants.textStyle5
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: AppButtonWidget(
                      alignment: Alignment.centerLeft,
                      onTap: () => Navigator.pop(sheetContext, false),
                      text: 'Нет',
                      backgroundColor: UiConstants.whiteColor,
                      textColor: UiConstants.black3Color.withOpacity(.6),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AppButtonWidget(
                        onTap: () async {
                          final firebaseManager = sl<FirebaseManager>();
                          bool isSuccess = await firebaseManager
                              .requestPushPermission(context);
                          Navigator.pop(sheetContext, isSuccess);
                        },
                        text: 'Включить уведомления',
                        backgroundColor: UiConstants.blueColor),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool?> showDeleteAccountSheet(BuildContext context) {
    return showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (sheetContext) {
        return CustomBottomSheet(
          height: 158.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Вы дейстивильно хотите удалить аккаунт?',
                style: UiConstants.textStyle5
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: AppButtonWidget(
                      alignment: Alignment.centerLeft,
                      onTap: () {
                        Navigator.pop(sheetContext, true);
                      },
                      text: 'Удалить',
                      backgroundColor: UiConstants.whiteColor,
                      textColor: UiConstants.black3Color.withOpacity(.6),
                    ),
                  ),
                  Expanded(
                    child: AppButtonWidget(
                        onTap: () => Navigator.pop(sheetContext, false),
                        text: 'Нет',
                        backgroundColor: UiConstants.blueColor),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

static Future<bool?> showSaveAdressSheet(BuildContext context, OrderDeliveryPersonalDataBloc bloc) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    builder: (sheetContext) {
      return CustomBottomSheet(
        height: 250.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Сохранить адрес доставки?',
              style: UiConstants.textStyle5
                  .copyWith(color: UiConstants.darkBlueColor),
            ),
            SizedBox(height: 16.h),
            Text(
              '${bloc.cityController.text} ${bloc.districtAndBuildingController.text} ${bloc.entranceController.text} ${bloc.floorController.text} ${bloc.apartmentController.text}',
              style: UiConstants.textStyle3
                  .copyWith(color: UiConstants.black3Color.withOpacity(.6)),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: AppButtonWidget(
                    alignment: Alignment.centerLeft,
                    onTap: () {
                      Navigator.pop(sheetContext, false); // <- возвращаем false
                    },
                    text: 'Не сохранять',
                    backgroundColor: UiConstants.whiteColor,
                    textColor: UiConstants.black3Color.withOpacity(.6),
                  ),
                ),
                Expanded(
                  child: AppButtonWidget(
                    onTap: () {
                      bloc.add(UpdateDeliveryAdressEvent());
                      Navigator.pop(sheetContext, true);
                    },
                    text: 'Сохранить',
                    backgroundColor: UiConstants.blueColor,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    },
  );

  return result;
}
}
