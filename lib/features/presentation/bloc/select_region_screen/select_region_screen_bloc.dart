import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'select_region_screen_event.dart';
part 'select_region_screen_state.dart';

class SelectRegionScreenBloc
    extends Bloc<SelectRegionScreenEvent, SelectRegionScreenState> {
  final TextEditingController regionController = TextEditingController();

  SelectRegionScreenBloc()
      : super(
          SelectRegionScreenState(
            popularCities: [
              'Санкт-Петербург и ЛО',
              'Новгородская область',
              'Псковская область',
              'Республика Карелия',
              'Мурманская область',
            ],
          ),
        ) {
    regionController.addListener(() {
      add(RegionChangedEvent(regionController.text));
    });

    on<RegionChangedEvent>((event, emit) {
      emit(
        state.copyWith(
            isButtonActive: regionController.text.isNotEmpty ||
                state.selectedRegion != null,
            showError: !state.popularCities.contains(event.region) &&
                regionController.text.isNotEmpty),
      );
    });
  }

  @override
  Future<void> close() {
    regionController.dispose();
    return super.close();
  }
}
