import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/core/params/search_param.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/domain/entities/region_entity.dart';
import 'package:nevis/features/domain/entities/search_autocomplete_entity.dart';
import 'package:nevis/features/domain/entities/search_results_entity.dart';
import 'package:nevis/features/domain/usecases/regions/get_regions.dart';
import 'package:nevis/features/domain/usecases/regions/select_region.dart';
import 'package:nevis/features/domain/usecases/search/autocomplete_search.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  final GetRegionsUC getRegionsUC;
  final SelectRegionUC selectRegionUC;
  final AutocompleteSearchUC autocompleteSearchUC;

  Timer? _debounce;

  SearchScreenBloc({
    required this.getRegionsUC,
    required this.selectRegionUC,
    required this.autocompleteSearchUC,
  }) : super(
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
    on<PerformSearchEvent>(_onPerformSearch);
    on<GetAutocompleteEvent>(_onGetAutocomplete);
    on<ClearFocusEvent>(_onClearFocus);
    add(GetRegionsEvent());
  }

  void _onChangeQuery(ChangeQueryEvent event, Emitter<SearchScreenState> emit) {
    final query = event.query;
    if (state.regionSelectionPressed) {
      if (query.isEmpty) {
        emit(state.copyWith(
          query: query,
          regionSuggestions: state.regions,
          errorMessage: null,
        ));
      } else {
        final results = state.regions
            .where((item) => item.name
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
        emit(state.copyWith(
          query: query,
          regionSuggestions: results,
          errorMessage: results.isEmpty ? 'Нет совпадений' : null,
        ));
      }
    } else {
      emit(state.copyWith(query: query));
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      if (query.length >= 3) {
        _debounce = Timer(const Duration(seconds: 2), () {
          add(GetAutocompleteEvent(query));
        });
      }
    }
  }

  void _onSelectSuggestions(
      SelectSuggestionsEvent event, Emitter<SearchScreenState> emit) {
    emit(state.copyWith(isExpanded: false, query: ''));
  }

  void _onClearQuery(ClearQueryEvent event, Emitter<SearchScreenState> emit) {
    emit(state.copyWith(
        isExpanded: false, query: '', regionSelectionPressed: false));
  }

  void _onToggleExpandCollapse(
      ToggleExpandCollapseEvent event, Emitter<SearchScreenState> emit) {
    emit(state.copyWith(isExpanded: event.isExpanded));
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
    emit(state.copyWith(regionSelectionPressed: pressed));
  }

  void _onGetAutocomplete(
      GetAutocompleteEvent event, Emitter<SearchScreenState> emit) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(
        autocompleteResults: null,
        isAutocompleteLoading: false,
        errorMessage: null,
      ));
      return;
    }

    emit(state.copyWith(isAutocompleteLoading: true));
    final result = await autocompleteSearchUC(event.query);

    result.fold(
      (failure) => emit(state.copyWith(
        isAutocompleteLoading: false,
        errorMessage: 'Ошибка получения подсказок',
      )),
      (suggestions) => emit(state.copyWith(
        autocompleteResults: [suggestions],
        isAutocompleteLoading: false,
        errorMessage: null,
      )),
    );
  }

  Future<List<ProductEntity>> getProductSuggestions(String query) async {
    final result = await autocompleteSearchUC(query);

    return result.fold((failure) => [], (suggestions) => suggestions.products);
  }

  Future<List<RegionEntity>> getRegions(String query) async {
    final result = await getRegionsUC();

    return result.fold((failure) => [], (suggestions) => suggestions);
  }

  void _onPerformSearch(
      PerformSearchEvent event, Emitter<SearchScreenState> emit) async {
    emit(state.copyWith(
        isSearching: true, isExpanded: false, query: event.params.query));
    emit(state.copyWith(isSearching: false));
  }

  void _onClearFocus(ClearFocusEvent event, Emitter<SearchScreenState> emit) {
    emit(state.copyWith(isSearching: false, isExpanded: false));
  }
}
