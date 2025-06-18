part of 'search_screen_bloc.dart';

class SearchScreenState extends Equatable {
  final bool isExpanded;
  final String query;
  final List<RegionEntity> regionSuggestions;
  final List<RegionEntity> regions;
  final bool isLoading;
  final String? errorMessage;
  final bool regionSelectionPressed;
  final List<SearchAutocompleteEntity>? autocompleteResults;
  final SearchResultsEntity? searchResults;
  final bool isSearching;
  final bool isAutocompleteLoading;

  const SearchScreenState({
    required this.errorMessage,
    required this.regionSelectionPressed,
    required this.regions,
    required this.isLoading,
    this.isExpanded = false,
    required this.query,
    required this.regionSuggestions,
    this.autocompleteResults,
    this.searchResults,
    this.isSearching = false,
    this.isAutocompleteLoading = false,
  });

  SearchScreenState copyWith({
    bool? isExpanded,
    String? query,
    List<RegionEntity>? regionSuggestions,
    List<RegionEntity>? regions,
    String? errorMessage,
    bool? regionSelectionPressed,
    bool? isLoading,
    List<SearchAutocompleteEntity>? autocompleteResults,
    SearchResultsEntity? searchResults,
    bool? isSearching,
    bool? isAutocompleteLoading,
  }) {
    return SearchScreenState(
      isExpanded: isExpanded ?? this.isExpanded,
      query: query ?? this.query,
      regionSuggestions: regionSuggestions ?? this.regionSuggestions,
      regions: regions ?? this.regions,
      errorMessage: errorMessage ?? this.errorMessage,
      regionSelectionPressed:
          regionSelectionPressed ?? this.regionSelectionPressed,
      isLoading: isLoading ?? this.isLoading,
      autocompleteResults: autocompleteResults ?? this.autocompleteResults,
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
      isAutocompleteLoading:
          isAutocompleteLoading ?? this.isAutocompleteLoading,
    );
  }

  @override
  List<Object?> get props => [
        isExpanded,
        query,
        regionSuggestions,
        isLoading,
        regions,
        regionSelectionPressed,
        errorMessage,
        autocompleteResults,
        searchResults,
        isSearching,
        isAutocompleteLoading,
      ];
}
