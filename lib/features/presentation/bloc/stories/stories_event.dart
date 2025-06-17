part of 'stories_bloc.dart';

abstract class StoriesEvent extends Equatable {
  const StoriesEvent();

  @override
  List<Object?> get props => [];
}

class LoadStoryEvent extends StoriesEvent {
  final int id;

  const LoadStoryEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
