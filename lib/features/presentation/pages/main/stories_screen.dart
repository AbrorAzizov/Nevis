import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/custom_cache_manager.dart';
import 'package:nevis/features/presentation/bloc/stories/stories_bloc.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:nevis/locator_service.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:story/story_page_view.dart';
import 'package:url_launcher/url_launcher.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int storyId = args?['id'];

    return BlocProvider(
      create: (context) => StoriesBloc(
        getStoryByIdUC: sl(),
      )..add(LoadStoryEvent(id: storyId)),
      child: BlocBuilder<StoriesBloc, StoriesState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: UiConstants.backgroundColor,
            body: SafeArea(
              child: Skeletonizer(
                enabled: state.isLoading,
                child: Padding(
                  padding: getMarginOrPadding(
                      left: 20, right: 20, bottom: 16, top: 16),
                  child: StoryPageView(
                      backgroundColor: UiConstants.backgroundColor,
                      indicatorVisitedColor: UiConstants.blue6Color,
                      indicatorUnvisitedColor: UiConstants.blue4Color,
                      pageLength: 1,
                      indicatorHeight: 4,
                      storyLength: (pageIndex) =>
                          state.story?.steps?.length ?? 1,
                      indicatorPadding: EdgeInsets.zero,
                      itemBuilder: (context, pageIndex, storyIndex) {
                        final step = state.story?.steps?[storyIndex];
                        return Container(
                          padding: getMarginOrPadding(top: 50, bottom: 40),
                          color: UiConstants.backgroundColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.story?.title ?? '',
                                style: UiConstants.textStyle17
                                    .copyWith(color: UiConstants.black3Color),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                step?.text ?? state.story?.description ?? '',
                                style: UiConstants.textStyle3
                                    .copyWith(color: UiConstants.black3Color),
                              ),
                              Spacer(),
                              CachedNetworkImage(
                                imageUrl: step?.imageUrl ??
                                    state.story?.imageUrl ??
                                    '',
                                fit: BoxFit.fill,
                                height: 320.h,
                                width: double.infinity,
                                cacheManager: CustomCacheManager(),
                                errorWidget: (context, url, error) => Icon(
                                    Icons.image,
                                    size: 56.w,
                                    color: UiConstants.whiteColor),
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                  child: CircularProgressIndicator(
                                      color: UiConstants.blueColor),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        );
                      },
                      gestureItemBuilder: (context, pageIndex, storyIndex) {
                        final step = state.story?.steps?[storyIndex];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                padding: getMarginOrPadding(top: 14, right: 6),
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.close,
                                  color:
                                      UiConstants.black3Color.withOpacity(.6),
                                ),
                              ),
                            ),
                            Spacer(),
                            if (step?.buttons.isNotEmpty ?? false)
                              ...step!.buttons.map(
                                (button) => Padding(
                                  padding: getMarginOrPadding(bottom: 8),
                                  child: AppButtonWidget(
                                    text: button.text,
                                    onTap: () {
                                      if (button.action == 'url' &&
                                          button.url != null) {
                                        launchUrl((Uri.parse(button.url!)));
                                      }
                                    },
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                      onPageLimitReached: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
