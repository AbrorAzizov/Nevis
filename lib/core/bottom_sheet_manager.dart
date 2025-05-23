import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/code_screen/code_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/order/order_pickup_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/cart_pharmacy_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_address_block.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_customer_block.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_payment_block.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_plate_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/online_payment_method_button.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/products_list_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/custom_bottom_sheet.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/map/pharmacy_map_widget.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_info_list.dart';
import 'package:nevis/features/presentation/widgets/pinput_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

  static showDeliverySheet(BuildContext homeContext) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: homeContext,
      builder: (sheetContext) {
        return CustomBottomSheet(
          color: UiConstants.backgroundColor,
          child: Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Text(
                  'Доставка',
                  style: UiConstants.textStyle1
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
                SizedBox(height: 16.h),
                InfoPlateWidget(
                    text:
                        'Доставка производится только по Минску и Минскому району'),
                SizedBox(height: 16.h),
                DeliveryCustomerBlock(screenContext: homeContext),
                SizedBox(height: 16.h),
                DeliveryAddressBlock(
                  screenContext: homeContext,
                  onPickAddressOnMap: () =>
                      showSelectAddressOnMapSheet(homeContext, sheetContext),
                ),
                SizedBox(height: 16.h),
                DeliveryPaymentBlock(
                  screenContext: homeContext,
                  changedOnlineMethodTap: () =>
                      showPickOnlinePaymentSheet(homeContext, sheetContext),
                ),
                SizedBox(height: 16.h),
                AppButtonWidget(
                  text: 'Оформить заказ',
                  isActive: true,
                  onTap: () {
                    showThanksForOrderSheet(homeContext);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static showPickOnlinePaymentSheet(
      BuildContext homeContext, BuildContext screenContext) {
    return showModalBottomSheet(
      context: homeContext,
      builder: (sheetContext) {
        return CustomBottomSheet(
          height: 300.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Оплата онлайн',
                style: UiConstants.textStyle5
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
              SizedBox(height: 16.h),
              OnlinePaymentMethodButton(
                child: Padding(
                  padding: getMarginOrPadding(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(Paths.cardIconPath,
                          width: 24.w, height: 24.w),
                      SizedBox(width: 8.w),
                      Text(
                        'Картой',
                        style: UiConstants.textStyle3.copyWith(
                            color: UiConstants.darkBlueColor,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(screenContext);
                },
              ),
              OnlinePaymentMethodButton(
                child: SvgPicture.asset(Paths.oplatiIconPath),
                onTap: () {
                  Navigator.pop(screenContext);
                },
              ),
              OnlinePaymentMethodButton(
                child:
                    Image.asset(Paths.eripIconPath, width: 88.w, height: 44.h),
                onTap: () {
                  Navigator.pop(screenContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static showSelectAddressOnMapSheet(
      BuildContext homeContext, BuildContext screenContext) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: homeContext,
      builder: (sheetContext) {
        return CustomBottomSheet(
          color: UiConstants.backgroundColor,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Выбрать на карте',
                  style: UiConstants.textStyle1
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
                SizedBox(height: 16.h),
                InfoPlateWidget(
                    text:
                        'Доставка производится только по Минску и Минскому району'),
                SizedBox(height: 16.h),
                Skeleton.ignorePointer(
                  child: Skeleton.shade(
                    child: AppTextFieldWidget(
                      hintText: 'Искать улицу или район',
                      fillColor: UiConstants.white2Color,
                      controller: TextEditingController(),
                      prefixWidget: Skeleton.ignore(
                        child: SvgPicture.asset(Paths.searchIconPath),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: PharmacyMapWidget(
                    points: [],
                  ),
                ),
                SizedBox(height: 16.h),
                AppButtonWidget(
                  text: 'Подтвердить',
                  isActive: true,
                  onTap: () {
                    Navigator.pop(screenContext);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static showThanksForOrderSheet(BuildContext homeContext) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: homeContext,
      builder: (sheetContext) {
        final List<ProductEntity> cartProducts =
            homeContext.read<CartScreenBloc>().state.cartProducts;
        final Set<int> selectedProductIds =
            homeContext.read<CartScreenBloc>().state.selectedProductIds;

        List<ProductEntity> orderedProducts = cartProducts
            .where((e) => selectedProductIds.contains(e.productId))
            .toList();
        return CustomBottomSheet(
          color: UiConstants.backgroundColor,
          child: Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Text(
                  'Спасибо за заказ!',
                  style: UiConstants.textStyle1
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Статус заказов можно отслеживать в профиле в разделе «Заказы» или на главной странице.',
                  style: UiConstants.textStyle2.copyWith(
                    color: UiConstants.darkBlue2Color.withOpacity(.6),
                  ),
                ),
                SizedBox(height: 16.h),
                ProductsListWidget(
                    title: 'Товары',
                    products: orderedProducts,
                    productsListScreenType: ProductsListScreenType.order,
                    screenContext: homeContext),
                SizedBox(height: 16.h),
                Text(
                  'Информация о заказе',
                  style: UiConstants.textStyle5
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: getMarginOrPadding(all: 16),
                  decoration: BoxDecoration(
                    color: UiConstants.whiteColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: OrderInfoList(
                    order: OrderEntity(),
                  ),
                ),
                SizedBox(height: 32.h),
                AppButtonWidget(
                  text: 'К списку заказов',
                  isActive: true,
                  onTap: () {
                    Navigator.of(homeContext).popUntil(
                      (route) {
                        return route.settings.name == "/";
                      },
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static showSelectPharmacySheet(
      BuildContext homeContext, BuildContext screenContext) {
    CartScreenBloc cartBloc = screenContext.read<CartScreenBloc>();
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: homeContext,
      builder: (sheetContext) {
        int selectorIndex = 0;

        return BlocBuilder<CartScreenBloc, CartScreenState>(
          bloc: cartBloc,
          builder: (context, cartState) {
            return CustomBottomSheet(
              color: UiConstants.whiteColor,
              child: Expanded(
                child: BlocProvider(
                  create: (context) => SelectorCubit(index: selectorIndex),
                  child: BlocBuilder<SelectorCubit, SelectorState>(
                    builder: (context, state) {
                      return ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          Text(
                            'Самовывоз',
                            style: UiConstants.textStyle1
                                .copyWith(color: UiConstants.darkBlueColor),
                          ),
                          SizedBox(height: 16.h),
                          BlockWidget(
                            title: 'Выбор аптеки',
                            titleStyle: UiConstants.textStyle9,
                            clickableText:
                                '${cartState.filteredPharmacies.length} аптек',
                            child: CustomAppBar(
                              controller: TextEditingController(),
                              hintText: 'Искать аптеки',
                              backgroundColor: Colors.transparent,
                              contentPadding: EdgeInsets.zero,
                              isShowFavoriteButton: true,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          // селектор список/карта
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Selector(
                              titlesList: const ['Список', 'Карта'],
                              onTap: (int index) => selectorIndex = index,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          if (selectorIndex == 0)
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    CartPharmacyWidget(
                                        pharmacy:
                                            ProductPharmacyEntity(), // TODO: доделать
                                        pharmacyListScreenType:
                                            PharmacyListScreenType.cart,
                                        onButtonTap: () => (),
                                        screenContext: homeContext),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 8.h),
                                itemCount: cartState.filteredPharmacies.length)
                          else
                            SizedBox(
                              height: 510.h,
                              child: PharmacyMapWidget(
                                points: [],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static showProductReceiptNotificationSheet(BuildContext homeContext) {
    showModalBottomSheet(
      context: homeContext,
      builder: (sheetContext) {
        return CustomBottomSheet(
          height: 180.h,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Мы сообщим вам о поступлении данного товара пуш‑уведомлением',
                  style: UiConstants.textStyle5
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
                Spacer(),
                AppButtonWidget(
                  text: 'Продолжить покупки',
                  onTap: () => Navigator.pop(sheetContext),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showConfirmationCodeSheet(BuildContext homeContext,
      BuildContext screenContext, PersonalDataScreenBloc personalDataBloc) {
    final bloc = screenContext.read<CodeScreenBloc>();
    showModalBottomSheet(
      context: homeContext,
      builder: (sheetContext) {
        return BlocBuilder<CodeScreenBloc, CodeScreenState>(
          bloc: bloc,
          builder: (context, state) {
            return CustomBottomSheet(
              height: 365,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Введите код подтверждения',
                    style: UiConstants.textStyle5
                        .copyWith(color: UiConstants.darkBlueColor),
                  ),
                  SizedBox(height: 8.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Мы отправили код на номер\n',
                          style: UiConstants.textStyle3.copyWith(
                            color: UiConstants.darkBlue2Color.withOpacity(.6),
                          ),
                        ),
                        TextSpan(
                          text: personalDataBloc.phoneController.text,
                          style: UiConstants.textStyle3.copyWith(
                              color: UiConstants.darkBlue2Color.withOpacity(.6),
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Center(
                    child: PinputWidget(
                        controller: bloc.codeController,
                        focusNode: bloc.codeFocusNode,
                        showError: bloc.state.showError),
                  ),
                  SizedBox(height: 32.h),
                  AppButtonWidget(
                    isActive: bloc.state.isButtonActive,
                    text: 'Подтвердить',
                    onTap: () => bloc.add(SubmitCodeEvent()),
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: Builder(
                      builder: (context) {
                        return bloc.state.canRequestNewCode
                            ? GestureDetector(
                                onTap: () => bloc.add(RequestNewCodeEvent()),
                                child: Text(
                                  'Запросить код снова',
                                  style: UiConstants.textStyle3
                                      .copyWith(color: UiConstants.blueColor),
                                ),
                              )
                            : Text(
                                'Запросить код ещё раз через ${Utils.formatSecondToMMSS(bloc.state.secondsLeft)}',
                                style: UiConstants.textStyle3.copyWith(
                                    color: UiConstants.mutedVioletColor),
                              );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  static showPharmacySort2Sheet(
      BuildContext homeContext, BuildContext screenContext) {
    showModalBottomSheet(
      context: homeContext,
      builder: (sheetContext) {
        CartScreenBloc cartBloc = screenContext.read<CartScreenBloc>();
        return BlocBuilder<CartScreenBloc, CartScreenState>(
          bloc: cartBloc,
          builder: (context, state) {
            return CustomBottomSheet(
              height: 200.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Фильтр',
                    style: UiConstants.textStyle5
                        .copyWith(color: UiConstants.darkBlueColor),
                  ),
                  SizedBox(height: 16.h),
                  CustomCheckbox(
                    onChanged: (isChecked) {},
                    title: Text(
                      'Работает сейчас',
                      style: UiConstants.textStyle2
                          .copyWith(color: UiConstants.darkBlueColor),
                    ),
                    isChecked: state.isShowPharmaciesWorkingNow,
                    // onChanged: (isChecked) => cartBloc.add(
                    //     // ToggleShowPharmaciesWorkingNowEvent(isChecked),
                    //     ),
                  ),
                  SizedBox(height: 8.h),
                  CustomCheckbox(
                    onChanged: (isChecked) {},

                    title: Text(
                      'Все товары в наличии',
                      style: UiConstants.textStyle2
                          .copyWith(color: UiConstants.darkBlueColor),
                    ),
                    isChecked: state.isShowPharmaciesProductsInStock,
                    // onChanged: (isChecked) => cartBloc.add(
                    //   ToggleShowPharmaciesProductsInStockEvent(isChecked),
                    // ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
