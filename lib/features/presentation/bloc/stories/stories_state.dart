part of 'stories_bloc.dart';

class StoriesState extends Equatable {
  final bool isLoading;
  final StoryEntity? story;
  final String? error;

  const StoriesState({
    this.isLoading = false,
    this.story,
    this.error,
  });

  StoriesState copyWith({
    bool? isLoading,
    StoryEntity? story,
    String? error,
  }) {
    return StoriesState(
      isLoading: isLoading ?? this.isLoading,
      story: story ?? this.story,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, story, error];
}
