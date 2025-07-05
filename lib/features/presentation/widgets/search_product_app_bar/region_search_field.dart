import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/domain/entities/region_entity.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:searchfield/searchfield.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RegionSearchField extends StatefulWidget {
  const RegionSearchField({super.key});

  @override
  State<RegionSearchField> createState() => _RegionSearchFieldState();
}

class _RegionSearchFieldState extends State<RegionSearchField> {
  late FocusNode focusNode;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.unfocus();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      builder: (context, state) {
        final bloc = context.read<SearchScreenBloc>();

        return Skeleton.ignorePointer(
          child: Skeleton.shade(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF144B63).withOpacity(0.1),
                    blurRadius: 50,
                    spreadRadius: -4,
                    offset: Offset(-1, -4),
                  ),
                ],
              ),
              child: SearchField<RegionEntity>(
                  focusNode: focusNode,
                  controller: controller,
                  suggestionItemDecoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.none),
                  ),
                  maxSuggestionBoxHeight: 124.h,
                  hint: '',
                  suggestions: List.generate(
                    state.regions.length,
                    (index) {
                      final item = state.regions[index];
                      return SearchFieldListItem(
                        item.name.toString(),
                        item: item,
                        child: Text(
                          item.name ?? '',
                          style: UiConstants.textStyle10.copyWith(
                              color: state.regions[index].isDefault ?? false
                                  ? UiConstants.blueColor
                                  : UiConstants.black3Color),
                        ),
                      );
                    },
                  ),
                  searchInputDecoration: SearchInputDecoration(
                      fillColor: UiConstants.whiteColor,
                      filled: true,
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      contentPadding: getMarginOrPadding(
                          left: 16, right: 16, top: 10, bottom: 10),
                      hintStyle: UiConstants.textStyle3.copyWith(
                          color: UiConstants.darkBlue2Color.withOpacity(.6),
                          height: 1),
                      prefixIcon: Padding(
                        padding: getMarginOrPadding(left: 16, right: 12),
                        child: SvgPicture.asset(Paths.searchIconPath),
                      ),
                      prefixIconConstraints: BoxConstraints(maxWidth: 52.w),
                      suffixIconConstraints: BoxConstraints(maxWidth: 52.w),
                      suffixIcon: controller.text.isNotEmpty
                          ? Skeleton.ignore(
                              child: GestureDetector(
                                onTap: () {
                                  controller.clear();
                                  FocusScope.of(context).unfocus();
                                },
                                child: SvgPicture.asset(Paths.closeIconPath),
                              ),
                            )
                          : null),
                  suggestionsDecoration: SuggestionDecoration(
                    color: UiConstants.whiteColor,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16.r),
                    ),
                  ),
                  onSearchTextChanged: (String query) async {
                    return state.regions
                        .where((e) => e.name!
                            .toLowerCase()
                            .startsWith(query.toLowerCase()))
                        .map(
                          (region) => SearchFieldListItem<RegionEntity>(
                            region.name ?? '',
                            item: region,
                            child: Text(
                              region.name ?? '',
                              style: UiConstants.textStyle10.copyWith(
                                  color: region.isDefault ?? false
                                      ? UiConstants.blueColor
                                      : UiConstants.black3Color),
                            ),
                          ),
                        )
                        .toList();
                  },
                  onSuggestionTap: (SearchFieldListItem<RegionEntity> item) {
                    if (item.searchKey.isNotEmpty) {
                      bloc.add(SelectRegionEvent(id: item.item!.id!));
                    }
                  },
                  onTapOutside: (p0) {
                    FocusScope.of(context).unfocus();
                    focusNode.unfocus();
                    bloc.add(ClearQueryEvent());
                  },
                  suggestionState: Suggestion.expand),
            ),
          ),
        );
      },
    );
  }
}
