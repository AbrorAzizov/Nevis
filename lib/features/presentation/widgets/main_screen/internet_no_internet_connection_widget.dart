import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/presentation/bloc/no_internet_connection/no_internet_connection_bloc.dart';
import 'package:nevis/features/presentation/bloc/orders_screen/orders_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/profile/favorite_pharmacies_screen.dart';
import 'package:nevis/features/presentation/widgets/main_screen/qr_code_widget.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_item.dart';
import 'package:nevis/locator_service.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NoInternetConnectionBloc(getQRCodeUC: sl())..add(LoadDataEvent()),
      child: BlocBuilder<NoInternetConnectionBloc, NoInternetConnectionState>(
        builder: (context, state) {
          return Padding(
            padding:
                getMarginOrPadding(left: 20, right: 20, bottom: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Paths.noInternetConnectionIconPath),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Интернет-соединение отсутствует',
                      style: UiConstants.textStyle3
                          .copyWith(color: UiConstants.black3Color),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                if (state.loyalCard != null)
                  QrCodeWidget(loyaltyCardQREntity: state.loyalCard!),
                if (state.loyalCard != null) SizedBox(height: 16.h),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: UiConstants.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF144B63).withOpacity(0.1),
                          blurRadius: 50,
                          spreadRadius: -4,
                          offset: Offset(-1, -4),
                        ),
                      ]),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(Routes.createRoute(
                        const FavoritePharmaciesScreen(),
                        settings: RouteSettings(
                            name: Routes.favoritePharmacy,
                            arguments: <ProductPharmacyEntity>[]),
                      ));
                    },
                    child: Padding(
                      padding: getMarginOrPadding(all: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Paths.geoIconPath,
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text('Найти аптеку на карте',
                                  style: UiConstants.textStyle3.copyWith(
                                    color: UiConstants.black3Color,
                                  ))
                            ],
                          ),
                          RotatedBox(
                              quarterTurns: 2,
                              child: SvgPicture.asset(Paths.arrowBackIconPath))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                BlocBuilder<OrdersScreenBloc, OrdersScreenState>(
                    builder: (context, ordersState) {
                  if (ordersState is OrdersScreenLoadedSuccessfully) {
                    return Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => OrderItem(
                                canNavigate: false,
                                order: ordersState.orders[index],
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8.h),
                          itemCount: ordersState.orders.length),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
