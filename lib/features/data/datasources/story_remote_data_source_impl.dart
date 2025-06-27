import 'dart:developer';

import 'package:nevis/core/api_client.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/features/data/models/paginated_stories_model.dart';
import 'package:nevis/features/data/models/story_model.dart';

abstract class StoryRemoteDataSource {
  Future<PaginatedStoriesModel> getStories(int page);
  Future<StoryModel> getStoryById(int id);
}

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final ApiClient apiClient;
  StoryRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<PaginatedStoriesModel> getStories(int page) async {
    try {
      final data = await apiClient.get(
        requireAuth: false,
        endpoint: 'stories?page=$page',
        exceptions: {500: ServerException()},
        callPathNameForLog: '${runtimeType.toString()}.getStories',
      );
      return PaginatedStoriesModel.fromJson(data);
    } catch (e) {
      log('Error during getStories: $e',
          name: '${runtimeType.toString()}.getStories', level: 1000);
      rethrow;
    }
  }

  @override
  Future<StoryModel> getStoryById(int id) async {
    try {
      final data = await apiClient.get(
        requireAuth: false,
        endpoint: 'stories/$id',
        exceptions: {500: ServerException()},
        callPathNameForLog: '${runtimeType.toString()}.getStoryById',
      );
      return StoryModel.fromJson(data['data']);
    } catch (e) {
      log('Error during getStoryById: $e',
          name: '${runtimeType.toString()}.getStoryById', level: 1000);
      rethrow;
    }
  }
}
