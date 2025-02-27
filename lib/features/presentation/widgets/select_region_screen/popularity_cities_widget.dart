import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/features/presentation/bloc/select_region_screen/select_region_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/main_screen/block_widget.dart';
import 'package:nevis/features/presentation/widgets/search_screen/search_history_item.dart';

class PopularityCitiesWidget extends StatelessWidget {
  const PopularityCitiesWidget(
      {super.key, required this.onTapRegion, required this.regions});

  final Function(String region) onTapRegion;
  final List<String> regions;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectRegionScreenBloc, SelectRegionScreenState>(
      builder: (context, state) {
        return BlockWidget(
          title: 'Популярные города',
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.w,
              children: List.generate(
                regions.length,
                (index) => SearchHistoryItem(
                  title: regions[index],
                  onTap: () => onTapRegion(
                    regions[index],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
