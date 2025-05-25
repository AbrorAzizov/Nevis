import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/widgets/app_button_widget.dart';
import 'package:story/story_page_view.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiConstants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: getMarginOrPadding(left: 20, right: 20, bottom: 16, top: 16),
          child: StoryPageView(
            backgroundColor: UiConstants.backgroundColor,
            indicatorVisitedColor: UiConstants.blue6Color,
            indicatorUnvisitedColor: UiConstants.blue4Color,
            pageLength: 1,
            indicatorHeight: 4,
            storyLength: (pageIndex) => 10,
            indicatorPadding: EdgeInsets.zero,
            itemBuilder: (context, pageIndex, storyIndex) {
              return Container(
                padding: getMarginOrPadding(top: 50, bottom: 40),
                color: UiConstants.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Будьте бдительны!',
                      style: UiConstants.textStyle17
                          .copyWith(color: UiConstants.black3Color),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'В последнее время участились случаи подделки лекарственных препаратов. Покупайте лекарственные препараты только у проверенных продавцов',
                      style: UiConstants.textStyle3
                          .copyWith(color: UiConstants.black3Color),
                    ),
                    Spacer(),
                    Image.asset(Paths.mockStoryPath, fit: BoxFit.cover),
                    Spacer(),
                  ],
                ),
              );
            },
            gestureItemBuilder: (context, pageIndex, storyIndex) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: getMarginOrPadding(top: 14, right: 6),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.close,
                        color: UiConstants.black3Color.withOpacity(.6),
                      ),
                    ),
                  ),
                  Spacer(),
                  AppButtonWidget(
                    text: 'Как избежать подделки',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
            onPageLimitReached: () {
              Navigator.pop(context); // закрыть сторис после последней
            },
          ),
        ),
      ),
    );
  }
}
