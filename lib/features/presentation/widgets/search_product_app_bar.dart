import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/bottom_sheet_manager.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_text_field_widget.dart';
import 'package:nevis/features/presentation/widgets/filter_button.dart';

import 'package:skeletonizer/skeletonizer.dart';

class SearchProductAppBar extends StatelessWidget {
  const SearchProductAppBar({
    super.key,
    this.onTapLocationChip,
    this.onTapBack,
    this.screenContext,
  });

  final Function()? onTapLocationChip;
  final Function()? onTapBack;
  final BuildContext? screenContext;

  @override
  Widget build(BuildContext context) {
    SearchScreenBloc searchBloc = context.read<SearchScreenBloc>();
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      bloc: searchBloc,
      builder: (context, state) {
        return Container(
          color: UiConstants.whiteColor,
          padding: getMarginOrPadding(top: 8, bottom: 8, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  if (onTapLocationChip != null && !state.isExpanded)
                    Skeleton.replace(
                      child: GestureDetector(
                        onTap: onTapLocationChip,
                        child: Padding(
                          padding: getMarginOrPadding(right: 8),
                          child: SvgPicture.asset(Paths.locationIconPath,
                              width: 24.w, height: 24.w),
                        ),
                      ),
                    ),
                  if (onTapBack != null)
                    Padding(
                      padding: getMarginOrPadding(right: 10),
                      child: GestureDetector(
                        onTap: onTapBack,
                        child: SvgPicture.asset(Paths.arrowBackIconPath,
                            color: UiConstants.darkBlue2Color.withOpacity(.6),
                            width: 24.w,
                            height: 24.w),
                      ),
                    ),
                  Expanded(
                    child: Skeleton.ignorePointer(
                      child: Skeleton.shade(
                        child: AppTextFieldWidget(
                          //focusNode: searchBloc.focusNode,
                          hintText: 'Искать препараты',
                          controller: searchBloc.searchController,
                          fillColor: UiConstants.white2Color,
                          hintMaxLines: 1,
                          prefixWidget: Skeleton.ignore(
                            child: SvgPicture.asset(Paths.searchIconPath),
                          ),
                          suffixWidget: state.isExpanded
                              ? Skeleton.ignore(
                                  child: GestureDetector(
                                    onTap: () =>
                                        searchBloc.add(ClearQueryEvent()),
                                    child:
                                        SvgPicture.asset(Paths.closeIconPath),
                                  ),
                                )
                              : null,
                          onChangedField: (p0) =>
                              searchBloc.add(ChangeQueryEvent(p0)),
                          onTapOutside: (event) {},
                          onTap: () =>
                              searchBloc.add(ToggleExpandCollapseEvent(true)),
                        ),
                      ),
                    ),
                  ),
                 
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
