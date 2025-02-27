import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/select_region_screen/select_region_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/home_screen.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/features/presentation/widgets/app_template.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/features/presentation/widgets/cart_screen/delivery_bottom_sheet/delivery_plate_widget.dart';
import 'package:nevis/features/presentation/widgets/select_region_screen/popularity_cities_widget.dart';

import 'package:skeletonizer/skeletonizer.dart';

class SelectRegionScreen extends StatelessWidget {
  const SelectRegionScreen({super.key, this.selectRegionScreenType});

  final SelectRegionScreenType? selectRegionScreenType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectRegionScreenBloc(),
      child: BlocBuilder<SelectRegionScreenBloc, SelectRegionScreenState>(
        builder: (context, state) {
          final bloc = context.read<SelectRegionScreenBloc>();

          return AppTemplate(
            canBack: selectRegionScreenType == SelectRegionScreenType.main,
            title: 'Выберите регион',
            bodyPadding:
                getMarginOrPadding(left: 20, right: 20, top: 16, bottom: 24),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Paths.locationIconPath,
                        width: 24.w, height: 24.w),
                    SizedBox(width: 8.w),
                    Text(
                      'Минск',
                      style: UiConstants.textStyle5
                          .copyWith(color: UiConstants.darkBlueColor),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'На основе вашей геолокации',
                  style: UiConstants.textStyle3.copyWith(
                    color: UiConstants.darkBlue2Color.withOpacity(.6),
                  ),
                ),
                SizedBox(height: 16.h),
                AppTextFieldWidget(
                  hintText: 'Найти другой город',
                  controller: bloc.regionController,
                  prefixWidget: SvgPicture.asset(Paths.searchIconPath),
                  suffixWidget: bloc.regionController.text.isNotEmpty
                      ? Skeleton.ignore(
                          child: GestureDetector(
                            onTap: () => bloc.regionController.clear(),
                            child: SvgPicture.asset(Paths.closeIconPath),
                          ),
                        )
                      : null,
                ),
                if (state.showError)
                  Padding(
                    padding: getMarginOrPadding(top: 16),
                    child: InfoPlateWidget(
                        text:
                            'Мы еще не работаем в этом городе, выберите другой'),
                  ),
                SizedBox(height: 16.h),
                PopularityCitiesWidget(
                  regions: state.popularCities,
                  onTapRegion: (String region) {
                    bloc.regionController.text = region;
                  },
                ),
                Spacer(),
                AppButtonWidget(
                  isActive: state.isButtonActive,
                  text: 'Подтвердить',
                  onTap: () {
                    if (selectRegionScreenType ==
                        SelectRegionScreenType.signUp) {
                      Navigator.of(context).pushAndRemoveUntil(
                          Routes.createRoute(
                            const HomeScreen(),
                          ),
                          (route) => false);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(height: 8.h),
                AppButtonWidget(
                  text: 'Пропустить',
                  isFilled: false,
                  onTap: () {
                    if (selectRegionScreenType ==
                        SelectRegionScreenType.signUp) {
                      Navigator.of(context).pushAndRemoveUntil(
                          Routes.createRoute(
                            const HomeScreen(),
                          ),
                          (route) => false);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
