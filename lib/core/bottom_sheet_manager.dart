import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/extensions.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/constants/utils.dart';
import 'package:nevis/core/formatters/date_input_formatter.dart';
import 'package:nevis/features/domain/entities/order_entity.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/code_screen/code_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/orders_screen/orders_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/personal_data_screen/personal_data_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/pharmacies_screen/pharmacies_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/products_screen/products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/cart_pharmacy_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_address_block.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_customer_block.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_payment_block.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_plate_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/online_payment_method_button.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/pharmacy_available_products_chip.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/products_list_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/cubit/selector_cubit.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/selector_widget.dart/selector/selector.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/summary_block/card_summary_block.dart';
import 'package:nevis/features/presentation/widgets/custom_app_bar.dart';
import 'package:nevis/features/presentation/widgets/custom_bottom_sheet.dart';
import 'package:nevis/features/presentation/widgets/custom_checkbox.dart';
import 'package:nevis/features/presentation/widgets/custom_radio_button.dart';
import 'package:nevis/features/presentation/widgets/dropdown_block_item.dart';
import 'package:nevis/features/presentation/widgets/dropdown_block_template.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/map/map_widget.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_info_list.dart';
import 'package:nevis/features/presentation/widgets/pinput_widget.dart';
import 'package:nevis/features/presentation/widgets/search_screen/price_range_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BottomSheetManager {
  static showClearCartSheet(BuildContext homeContext) {
    showModalBottomSheet(
      context: homeContext,
      builder: (sheetContext) {
        return CustomBottomSheet(
          height: 231.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Удалить все товары?',
                style: UiConstants.textStyle5
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
              SizedBox(height: 8.h),
              Text(
                'Отменить данное действие будет невозможно',
                style: UiConstants.textStyle3.copyWith(
                  color: UiConstants.darkBlue2Color.withOpacity(.6),
                ),
              ),
              SizedBox(height: 16.h),
              AppButtonWidget(
                text: 'Удалить',
                onTap: () {
                  homeContext.read<CartScreenBloc>().add(ClearProductsEvent());
                  Navigator.pop(sheetContext);
                },
              ),
              SizedBox(height: 8.h),
              AppButtonWidget(
                text: 'Отменить',
                isFilled: false,
                onTap: () => Navigator.pop(sheetContext),
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
                  homeContext.read<CartScreenBloc>().add(
                        ChangeCartTypeEvent(TypeReceiving.pickup),
                      );
                  homeContext.read<CartScreenBloc>().add(
                        ScrollUpListEvent(),
                      );
                  screenContext.read<SelectorCubit>().onSelectorItemTap(
                        [TypeReceiving.delivery, TypeReceiving.pickup]
                            .indexOf(TypeReceiving.pickup),
                      );
                  Navigator.pop(sheetContext);
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

  static showDeletePromoCodeSheet(BuildContext homeContext) {
    return showModalBottomSheet(
      context: homeContext,
      builder: (sheetContext) {
        return CustomBottomSheet(
          height: 186.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Удалить промокод?',
                style: UiConstants.textStyle5
                    .copyWith(color: UiConstants.darkBlueColor),
              ),
              SizedBox(height: 16.h),
              AppButtonWidget(
                text: 'Оставить',
                onTap: () => Navigator.pop(sheetContext),
              ),
              SizedBox(height: 8.h),
              AppButtonWidget(
                text: 'Удалить',
                isFilled: false,
                onTap: () {
                  homeContext.read<CartScreenBloc>().add(
                        DeletePromoCodeEvent(),
                      );
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
                  child: MapWidget(
                    mapObjects: [],
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
            homeContext.read<CartScreenBloc>().state.products;
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
                              isShowFilterButton: true,
                              onTapFilterButton: () => showPharmacySort2Sheet(
                                  homeContext, screenContext),
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
                                        onButtonTap: () => showPharmacySheet(
                                              homeContext,
                                              screenContext,
                                              cartState
                                                  .filteredPharmacies[index],
                                            ),
                                        screenContext: homeContext),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 8.h),
                                itemCount: cartState.filteredPharmacies.length)
                          else
                            SizedBox(
                              height: 510.h,
                              child: MapWidget(
                                mapObjects: [],
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

  static showPharmacySheet(
      BuildContext homeContext, BuildContext screenContext, Pharmacy pharmacy) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: homeContext,
      builder: (sheetContext) {
        final cartBloc = homeContext.read<CartScreenBloc>();

        List<ProductEntity> products = cartBloc.state.products;
        Set<int> selectedProductIds = cartBloc.state.selectedProductIds;

        List<ProductEntity> selectedProducts = products
            .where((product) => selectedProductIds.contains(product.productId))
            .toList();

        List<ProductEntity> noAvailableProducts = selectedProducts
            .where((product) =>
                !pharmacy.availableProducts.contains(product.productId))
            .toList();

        // Обновляем свойство inStock для каждого продукта
        //for (var product in noAvailableProducts) {
        //  product.inStock = false;
        //}

        //List<Product> availableProducts = selectedProducts
        //    .where((product) => pharmacy.availableProducts
        //        .map((e) => e.id)
        //        .contains(product.id))
        //    .toList();

        List<ProductEntity> availableProducts = [];

        return CustomBottomSheet(
          color: UiConstants.backgroundColor,
          child: Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Text(
                  'Аптека №36 InLek ОДО ДКМ-ФАРМ',
                  style: UiConstants.textStyle3
                      .copyWith(color: UiConstants.darkBlueColor),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Минский р-н, аг. Сеница, ул. Зеленая, 1, к. 5 (с/м Гиппо)',
                  style: UiConstants.textStyle2.copyWith(
                    color: UiConstants.darkBlueColor,
                  ),
                ),
                SizedBox(height: 16.h),
                PharmacyAvailableProductsChip(
                    allProductsAvailable: noAvailableProducts.isEmpty),
                SizedBox(height: 32.h),
                // список с законченными товарами
                if (noAvailableProducts.isNotEmpty)
                  Padding(
                    padding: getMarginOrPadding(bottom: 32),
                    child: ProductsListWidget(
                        title: 'Товары закончились',
                        subtitle:
                            'Эти товары останутся в корзине, их можно будет оформить отдельным заказом в другой аптеке.',
                        products: noAvailableProducts,
                        screenContext: homeContext,
                        productsListScreenType:
                            ProductsListScreenType.pharmacy),
                  ),
                ProductsListWidget(
                    title: 'В наличии',
                    products: availableProducts,
                    screenContext: homeContext,
                    productsListScreenType: ProductsListScreenType.pharmacy),
                // подсчёт стоимости
                if (cartBloc.state.products.isNotEmpty)
                  Padding(
                    padding: getMarginOrPadding(bottom: 16, top: 16),
                    child: CardSummaryBlock(
                        screenContext: screenContext, canUsePromoCodes: false),
                  ),

                AppButtonWidget(
                  text: 'Заберу отсюда',
                  isActive: true,
                  onTap: () {
                    cartBloc.add(SelectPharmacy(pharmacy.id));
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
                                      .copyWith(color: UiConstants.purpleColor),
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

  static showProductsFilterSheet(BuildContext homeContext,
      {SearchScreenBloc? searchBloc}) {
    SearchScreenBloc serchBloc = homeContext.read<SearchScreenBloc>();
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: homeContext.read<HomeScreenBloc>().context,
      builder: (sheetContext) {
        return BlocBuilder<SearchScreenBloc, SearchScreenState>(
          bloc: serchBloc,
          builder: (context, state) {
            return CustomBottomSheet(
              color: UiConstants.whiteColor,
              child: Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Фильтры',
                          style: UiConstants.textStyle5
                              .copyWith(color: UiConstants.darkBlueColor),
                        ),
                        GestureDetector(
                          onTap: () => searchBloc!.add(
                            ClearEvent(),
                          ),
                          child: Text(
                            'Сбросить',
                            style: UiConstants.textStyle3.copyWith(
                              color: UiConstants.darkBlue2Color.withOpacity(.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    PriceRangeWidget(homeContext: homeContext),
                    SizedBox(height: 11.h),
                    DropdownBlockTemplate(
                      title: 'Форма выпуска',
                      child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => DropdownBlockItem(
                                text: state.releaseForms[index],
                                isChecked: state.selectedReleaseFormsId
                                    .contains(index),
                                onChanged: (isChecked) => searchBloc!.add(
                                  SelectReleaseFormEvent(index, isChecked),
                                ),
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8),
                          itemCount: state.releaseForms.length),
                    ),
                    SizedBox(height: 16.h),
                    DropdownBlockTemplate(
                      title: 'Страна производства',
                      child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => DropdownBlockItem(
                                text: state.manufacturers[index],
                                isChecked: state.selectedManufacturersId
                                    .contains(index),
                                onChanged: (isChecked) => searchBloc!.add(
                                  SelectManufacturerEvent(index, isChecked),
                                ),
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8),
                          itemCount: state.manufacturers.length),
                    ),
                    Padding(
                      padding: getMarginOrPadding(top: 16, bottom: 16),
                      child: Divider(
                        color: UiConstants.white5Color,
                      ),
                    ),
                    DropdownBlockItem(
                      text: 'Без рецепта',
                      isChecked: state.isWithoutPrescription,
                      onChanged: (isChecked) => searchBloc!.add(
                        ToggleWithoutPrescriptionEvent(isChecked),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    DropdownBlockItem(
                      text: 'Участвует в акции',
                      isChecked: state.isParticipatesInCampaign,
                      onChanged: (isChecked) => searchBloc!.add(
                        ToggleParticipatesInCampaignEvent(isChecked),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    DropdownBlockItem(
                      text: 'Возможна доставка',
                      isChecked: state.isDeliveryPossible,
                      onChanged: (isChecked) => searchBloc!.add(
                        ToggleDeliveryPossibleEvent(isChecked),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AppButtonWidget(
                      text: 'Показать результаты',
                      onTap: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static showProductSortSheet(
      BuildContext homeContext, BuildContext screenContext) {
    showModalBottomSheet(
      context: homeContext,
      builder: (sheetContext) {
        ProductsScreenBloc productsBloc =
            screenContext.read<ProductsScreenBloc>();
        return BlocBuilder<ProductsScreenBloc, ProductsScreenState>(
          bloc: productsBloc,
          builder: (context, state) {
            return CustomBottomSheet(
              height: 200.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Сортировка',
                    style: UiConstants.textStyle5
                        .copyWith(color: UiConstants.darkBlueColor),
                  ),
                  SizedBox(height: 16.h),
                  CustomRadioButton(
                    isLabelOnLeft: true,
                    title: 'По популярности',
                    textStyle: UiConstants.textStyle2,
                    value: ProductSortType.popularity,
                    groupValue: state.productSortType,
                    onChanged: () => productsBloc.add(
                      ChangeProductSortTypeEvent(ProductSortType.popularity),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomRadioButton(
                    isLabelOnLeft: true,
                    title: 'По возрастанию цены',
                    textStyle: UiConstants.textStyle2,
                    value: ProductSortType.priceIncrease,
                    groupValue: state.productSortType,
                    onChanged: () => productsBloc.add(
                      ChangeProductSortTypeEvent(ProductSortType.priceIncrease),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomRadioButton(
                    isLabelOnLeft: true,
                    title: 'По убыванию цены',
                    textStyle: UiConstants.textStyle2,
                    value: ProductSortType.priceDecrease,
                    groupValue: state.productSortType,
                    onChanged: () => productsBloc.add(
                      ChangeProductSortTypeEvent(ProductSortType.priceDecrease),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static showPharmacySortSheet(
      BuildContext homeContext, BuildContext screenContext) {
    showModalBottomSheet(
      context: homeContext,
      builder: (sheetContext) {
        PharmaciesScreenBloc pharmaciesBloc =
            screenContext.read<PharmaciesScreenBloc>();
        return BlocBuilder<PharmaciesScreenBloc, PharmaciesScreenState>(
          bloc: pharmaciesBloc,
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
                  CustomRadioButton(
                    isLabelOnLeft: true,
                    title: 'Все способы получения',
                    textStyle: UiConstants.textStyle2,
                    value: TypeReceiving.all,
                    groupValue: state.pharmacySortType,
                    onChanged: () => pharmaciesBloc.add(
                      ChangePharmacySortTypeEvent(TypeReceiving.all),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomRadioButton(
                    isLabelOnLeft: true,
                    title: 'Самовывоз',
                    textStyle: UiConstants.textStyle2,
                    value: TypeReceiving.pickup,
                    groupValue: state.pharmacySortType,
                    onChanged: () => pharmaciesBloc.add(
                      ChangePharmacySortTypeEvent(TypeReceiving.pickup),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomRadioButton(
                    isLabelOnLeft: true,
                    title: 'Доставка',
                    textStyle: UiConstants.textStyle2,
                    value: TypeReceiving.delivery,
                    groupValue: state.pharmacySortType,
                    onChanged: () => pharmaciesBloc.add(
                      ChangePharmacySortTypeEvent(TypeReceiving.delivery),
                    ),
                  ),
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
                    title: Text(
                      'Работает сейчас',
                      style: UiConstants.textStyle2
                          .copyWith(color: UiConstants.darkBlueColor),
                    ),
                    isChecked: state.isShowPharmaciesWorkingNow,
                    onChanged: (isChecked) => cartBloc.add(
                      ToggleShowPharmaciesWorkingNowEvent(isChecked),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomCheckbox(
                    title: Text(
                      'Все товары в наличии',
                      style: UiConstants.textStyle2
                          .copyWith(color: UiConstants.darkBlueColor),
                    ),
                    isChecked: state.isShowPharmaciesProductsInStock,
                    onChanged: (isChecked) => cartBloc.add(
                      ToggleShowPharmaciesProductsInStockEvent(isChecked),
                    ),
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
