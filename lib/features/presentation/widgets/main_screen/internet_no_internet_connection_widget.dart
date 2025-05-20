import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';
import 'package:nevis/features/presentation/bloc/orders_screen/orders_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/profile/favorite_pharmacy_screen.dart';
import 'package:nevis/features/presentation/widgets/orders_screen/order_item.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getMarginOrPadding(left: 20, right: 20, bottom: 16, top: 16),
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
          SizedBox(
            height: 16.h,
          ),
          Container(
            height: 180.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF144B63).withOpacity(0.1),
                  blurRadius: 50,
                  spreadRadius: -4,
                  offset: Offset(-1, -4),
                ),
              ],
              image: DecorationImage(
                  image: AssetImage(Paths.qrCodeBackgorundIconPath),
                  fit: BoxFit.fill),
            ),
            child: Padding(
              padding: getMarginOrPadding(all: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Color(0xFFBF80FF),
                            Color(0xFF85C6FF),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds),
                        child: Text(
                          'ВАША КАРТА\nCASHBACK',
                          style: UiConstants.textStyle5.copyWith(
                              height: 1,
                              color: UiConstants.whiteColor,
                              letterSpacing: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        width: 132.w,
                        height: 42.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            gradient: LinearGradient(colors: [
                              Color(0xFFBF80FF),
                              Color(0xFF85C6FF)
                            ])),
                        child: Container(
                          padding: getMarginOrPadding(
                            left: 8,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  width: 24, height: 24, Paths.bonusIcon2Path),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: getMarginOrPadding(top: 4, bottom: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Бонусы',
                                        style: UiConstants.textStyle15.copyWith(
                                          color: UiConstants.whiteColor,
                                        )),
                                    Text('1488',
                                        style: UiConstants.textStyle19.copyWith(
                                          color: UiConstants.whiteColor,
                                        )),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Image.asset(
                      width: 148.w,
                      height: 148.h,
                      fit: BoxFit.fill,
                      Paths.qrCodeIconPath),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
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
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemCount: ordersState.orders.length),
              );
            } else {
              return SizedBox.shrink();
            }
          })
        ],
      ),
    );
  }
}
