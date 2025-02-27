import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/constants/enums.dart';
import 'package:nevis/features/domain/entities/product_pharmacy_entity.dart';

part 'pharmacies_screen_event.dart';
part 'pharmacies_screen_state.dart';

class PharmaciesScreenBloc
    extends Bloc<PharmaciesScreenEvent, PharmaciesScreenState> {
  TextEditingController queryController = TextEditingController();

  PharmaciesScreenBloc()
      : super(
          PharmaciesScreenState(),
        ) {
    on<ChangeSelectorIndexEvent>(
      (event, emit) async {
        emit(state.copyWith(selectorIndex: event.selectorIndex));
      },
    );

    on<ChangePharmacySortTypeEvent>(_onChangePharmacySortTypeEvent);
    on<ChangeQueryEvent>(_onChangeQueryEvent);
    on<LoadDataEvent>(_onLoadData);
  }

  void _onLoadData(LoadDataEvent event, Emitter<PharmaciesScreenState> emit) {
    emit(
      PharmaciesScreenState(
          selectorIndex: 0,
          pharmacySortType: TypeReceiving.all,
          pharmacies: event.pharmacies),
    );
  }

  void _onChangePharmacySortTypeEvent(
      ChangePharmacySortTypeEvent event, Emitter<PharmaciesScreenState> emit) {
    emit(
      state.copyWith(pharmacySortType: event.pharmacySortType),
    );
  }

  void _onChangeQueryEvent(
      ChangeQueryEvent event, Emitter<PharmaciesScreenState> emit) {
    emit(
      state.copyWith(query: event.query),
    );
  }
}
