import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:nevis/core/api_client.dart';
import 'package:nevis/features/data/models/action_model.dart';
import 'package:nevis/features/data/models/article_model.dart';
import 'package:nevis/features/data/models/banner_model.dart';
import 'package:nevis/features/data/models/news_model.dart';
import 'package:nevis/features/data/models/pharmacy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ContentRemoteDataSource {
  Future<List<NewsModel>> getNews();
  Future<NewsModel> getOneNews(int id);
  Future<List<ActionModel>> getActions();
  Future<ActionModel> getOneAction(int id);
  Future<List<ArticleModel>> getArticles();
  Future<ArticleModel> getOneArticle(int id);
  Future<List<BannerModel>> getBanners();
  Future<List<PharmacyModel>> getPharmacies(String address);
}

class ContentRemoteDataSourceImpl implements ContentRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ContentRemoteDataSourceImpl({
    required this.apiClient,
    required this.sharedPreferences,
  });

  @override
  Future<List<ActionModel>> getActions() async {
    try {
      final data = await apiClient.get(
        endpoint: 'actions/',
        callPathNameForLog: '${runtimeType.toString()}.getActions',
      );

      List<dynamic> dataList = data['data'];
      return dataList.map((e) => ActionModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getActions: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<ArticleModel>> getArticles() async {
    try {
      final data = await apiClient.get(
        endpoint: 'articles/',
        callPathNameForLog: '${runtimeType.toString()}.getArticles',
      );

      List<dynamic> dataList = data['data'];
      return dataList.map((e) => ArticleModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getArticles: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      final data = await apiClient.get(
        endpoint: 'banners/',
        callPathNameForLog: '${runtimeType.toString()}.getBanners',
      );

      Map<String, dynamic> dataMap = data['data'];
      var banners = <BannerModel>[];

      dataMap.forEach((_, value) {
        if (value is Map<String, dynamic>) {
          value.forEach((_, value) {
            String? image = value['items']['image_mobile']['value'];
            String? href = value['items']['href']['value'];

            if (image != null && href != null) {
              banners.add(BannerModel(image: image, href: href));
            }
          });
        }
      });

      return banners;
    } catch (e) {
      log('Error during getBanners: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<NewsModel>> getNews() async {
    try {
      final data = await apiClient.get(
        endpoint: 'news/',
        callPathNameForLog: '${runtimeType.toString()}.getNews',
      );

      List<dynamic> dataList = data['data'];
      return dataList.map((e) => NewsModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getNews: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<ActionModel> getOneAction(int id) async {
    try {
      final data = await apiClient.get(
        endpoint: 'actions/$id',
        callPathNameForLog: '${runtimeType.toString()}.getOneAction',
      );

      return ActionModel.fromJson(data['data']);
    } catch (e) {
      log('Error during getOneAction: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<ArticleModel> getOneArticle(int id) async {
    try {
      final data = await apiClient.get(
        endpoint: 'articles/$id',
        callPathNameForLog: '${runtimeType.toString()}.getOneArticle',
      );

      return ArticleModel.fromJson(data['data']);
    } catch (e) {
      log('Error during getOneArticle: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<NewsModel> getOneNews(int id) async {
    try {
      final data = await apiClient.get(
        endpoint: 'news/$id',
        callPathNameForLog: '${runtimeType.toString()}.getOneNews',
      );

      return NewsModel.fromJson(data['data']);
    } catch (e) {
      log('Error during getOneNews: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<PharmacyModel>> getPharmacies(String address) async {
    try {
      // Simulate loading from a local asset (e.g., mock data for testing)
      await Future.delayed(Duration(milliseconds: 500));
      final jsonString = await rootBundle.loadString('assets/pharmacies.json');
      final data = jsonDecode(jsonString);

      List<dynamic> dataList = data['data'];
      return dataList.map((e) => PharmacyModel.fromJson(e)).toList();
    } catch (e) {
      log('Error during getPharmacies: $e', level: 1000);
      rethrow;
    }
  }
}
