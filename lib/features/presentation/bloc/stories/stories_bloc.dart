import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/story_entity.dart';
import 'package:nevis/features/domain/usecases/stories/get_story_by_id_usecase.dart';

part 'stories_event.dart';
part 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  final GetStoryByIdUC getStoryByIdUC;

  StoriesBloc({
    required this.getStoryByIdUC,
  }) : super(StoriesState()) {
    on<LoadStoryEvent>(_onLoadStory);
  }

  void _onLoadStory(LoadStoryEvent event, Emitter<StoriesState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await getStoryByIdUC(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )),
      (story) => emit(state.copyWith(
        isLoading: false,
        story: story,
      )),
    );
  }
}
