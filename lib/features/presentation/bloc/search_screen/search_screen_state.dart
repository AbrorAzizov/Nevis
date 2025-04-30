part of 'search_screen_bloc.dart';

class SearchScreenState extends Equatable {
  final bool isExpanded;
  final String query;
  final List<RegionEntity> regionSuggestions;
  final List<RegionEntity> regions;
  final bool isLoading;
  final String? errorMessage;
  final bool regionSelectionPressed;

  const SearchScreenState({
    required this.errorMessage,
    required this.regionSelectionPressed,
    required this.regions,
    required this.isLoading,
    this.isExpanded = false,
    required this.query,
    required this.regionSuggestions,
  });

  SearchScreenState copyWith(
      {bool? isExpanded,
      String? query,
      List<RegionEntity>? regionSuggestions,
      List<RegionEntity>? regions,
      String? errorMessage,
      bool? regionSelectionPressed,
      bool? isLoading}) {
    return SearchScreenState(
      isExpanded: isExpanded ?? this.isExpanded,
      query: query ?? this.query,
      regionSuggestions: regionSuggestions ?? this.regionSuggestions,
      regions: regions ?? this.regions,
      errorMessage: errorMessage ?? this.errorMessage,
      regionSelectionPressed:
          regionSelectionPressed ?? this.regionSelectionPressed,
      isLoading: isLoading ?? this.isLoading,
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
        errorMessage
      ];
}
