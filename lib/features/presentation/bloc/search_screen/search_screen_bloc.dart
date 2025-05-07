import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nevis/features/domain/entities/region_entity.dart';
import 'package:nevis/features/domain/usecases/regions/get_regions.dart';
import 'package:nevis/features/domain/usecases/regions/select_region.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  TextEditingController searchProductController = TextEditingController();
  TextEditingController searchRegionController = TextEditingController();
  final GetRegionsUC getRegionsUC;
  final SelectRegionUC selectRegionUC;
  FocusNode focusNode = FocusNode();

  SearchScreenBloc({required this.getRegionsUC, required this.selectRegionUC})
      : super(
          SearchScreenState(
            isExpanded: false,
            query: '',
            regionSuggestions: const [],
            regions: const [],
            isLoading: false,
            errorMessage: null,
            regionSelectionPressed: false,
          ),
        ) {
    on<ToggleExpandCollapseEvent>(_onToggleExpandCollapse);
    on<ClearQueryEvent>(_onClearQuery);
    on<ChangeQueryEvent>(_onChangeQuery);
    on<SelectSuggestionsEvent>(_onSelectSuggestions);
    on<GetRegionsEvent>(_getRegions);
    on<ChangeControllerEvent>(_changeController);
    on<SelectRegionEvent>(_selectRegion);
  }

  void _onChangeQuery(ChangeQueryEvent event, Emitter<SearchScreenState> emit) {
    final query = event.query;
    if (query.isEmpty) {
      emit(state.copyWith(
        query: query,
        regionSuggestions: state.regions,
        errorMessage: null,
      ));
    } else {
      final results = state.regions
          .where((item) => item.name.toString().contains(query))
          .toList();
      emit(state.copyWith(
        query: query,
        regionSuggestions: results,
        errorMessage: results.isEmpty ? 'Нет совпадений' : null,
      ));
    }
  }

  void _onSelectSuggestions(
      SelectSuggestionsEvent event, Emitter<SearchScreenState> emit) {
    searchProductController.clear();
    emit(state.copyWith(isExpanded: false, query: ''));
  }

  void _onClearQuery(ClearQueryEvent event, Emitter<SearchScreenState> emit) {
    searchProductController.clear();
    emit(state.copyWith(
        isExpanded: false, query: '', regionSelectionPressed: false));
  }

  void _onToggleExpandCollapse(
      ToggleExpandCollapseEvent event, Emitter<SearchScreenState> emit) {
    emit(state.copyWith(
      isExpanded: event.isExpanded,
    ));
  }

  void _getRegions(
      GetRegionsEvent event, Emitter<SearchScreenState> emit) async {
    final failureOrLoads = await getRegionsUC();

    failureOrLoads.fold(
        (_) => emit(state.copyWith(
            isLoading: false, errorMessage: 'Ошибка загрузки данных')),
        (regions) => emit(state.copyWith(regions: regions)));
  }

  void _selectRegion(
      SelectRegionEvent event, Emitter<SearchScreenState> emit) async {
    emit(state.copyWith(isExpanded: false, regionSelectionPressed: false));
    final failureOrLoads = await selectRegionUC(event.id);
    failureOrLoads.fold(
        (_) => emit(state.copyWith(
            isLoading: false, errorMessage: 'Ошибка загрузки данных')), (_) {
      add(GetRegionsEvent());
    });
  }

  void _changeController(
      ChangeControllerEvent event, Emitter<SearchScreenState> emit) {
    final bool pressed = !state.regionSelectionPressed;
    emit(state.copyWith(regionSelectionPressed: pressed, isExpanded: pressed));
  }
}
