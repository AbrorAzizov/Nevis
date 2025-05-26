import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/pages/main/stories_screen.dart';
import 'package:nevis/features/presentation/widgets/main_screen/stories/story_item_widget.dart';

class StoryListWidget extends StatelessWidget {
  const StoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.w,
      child: ListView.separated(
          padding: getMarginOrPadding(left: 20, right: 20),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => StoryItemWidget(
                onTap: () {
                  Navigator.of(context.read<HomeScreenBloc>().context).push(
                    Routes.createRoute(
                      StoriesScreen(),
                      settings: RouteSettings(
                        name: Routes.storiesScreen,
                      ),
                    ),
                  );
                },
              ),
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemCount: 10),
    );
  }
}
