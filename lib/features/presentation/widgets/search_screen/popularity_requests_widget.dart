import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/search_screen/search_history_item.dart';

class PopularityRequestsWidget extends StatelessWidget {
  const PopularityRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlockWidget(
      title: 'История поиска',
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 8.w,
          runSpacing: 8.w,
          children: [
            SearchHistoryItem(
              title: 'Терафлю',
              onTap: () {},
            ),
            SearchHistoryItem(
              title: 'Виши',
              onTap: () {},
            ),
            SearchHistoryItem(
              title: 'Солгар',
              onTap: () {},
            ),
            SearchHistoryItem(
              title: 'Биодерма',
              onTap: () {},
            ),
            SearchHistoryItem(
              title: 'Бепантен',
              onTap: () {},
            ),
            SearchHistoryItem(
              title: 'Термометр',
              onTap: () {},
            ),
            SearchHistoryItem(
              title: 'Ля Рош Позе',
              onTap: () {},
            ),
            SearchHistoryItem(
              title: 'Урьяж',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
