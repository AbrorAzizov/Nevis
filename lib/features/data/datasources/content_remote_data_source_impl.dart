import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
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
  final http.Client client;
  final SharedPreferences sharedPreferences;

  ContentRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<List<ActionModel>> getActions() async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}actions/';
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    log('GET $url');

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $serverToken'
        },
      );

      log('Response ($url): ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> dataList = data['data'];

        return dataList.map((e) => ActionModel.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error during getActions: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<ArticleModel>> getArticles() async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}articles/';
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    log('GET $url');

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $serverToken'
        },
      );

      log('Response ($url): ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> dataList = data['data'];

        return dataList.map((e) => ArticleModel.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error during getArticles: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<BannerModel>> getBanners() async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}banners/';
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    log('GET $url');

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $serverToken'
        },
      );

      log('Response ($url): ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        // Пройдем по ключам aside (если их несколько) и извлечем нужные данные
        var banners = <BannerModel>[];

        Map<String, dynamic>? dataMap = data['data'];

        if (dataMap != null) {
          dataMap.forEach(
            (_, value) {
              if (value is Map<String, dynamic>) {
                value.forEach(
                  (_, value) {
                    String? image = value['items']['image_mobile']['value'];
                    String? href = value['items']['href']['value'];

                    // Если оба поля существуют, создаем BannerModel
                    if (image != null && href != null) {
                      banners.add(BannerModel(image: image, href: href));
                    }
                  },
                );
              }
            },
          );
        }

        // Обрабатываем каждый элемент в data['data']
        //data['data'].forEach((item) {
        //  // Пытаемся найти нужные данные внутри объекта
        //  var aside = item['aside'];
        //  if (aside != null && aside is Map) {
        //    // Пробегаем по всем возможным ключам aside
        //    aside.forEach((key, value) {
        //      if (value is Map && value['items'] is List) {
        //        // Для каждого элемента в 'items'
        //        value['items'].forEach((innerItem) {
        //          // Получаем значение 'image_mobile' и 'href' из подполей 'value'
        //          String? image = innerItem['image_mobile']?['value'];
        //          String? href = innerItem['href']?['value'];
//
        //          // Если оба поля существуют, создаем BannerModel
        //          if (image != null && href != null) {
        //            banners.add(BannerModel(image: image, href: href));
        //          }
        //        });
        //      }
        //    });
        //  }
        //});

        return banners;
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error during getBanners: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<NewsModel>> getNews() async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}news/';
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    log('GET $url');

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $serverToken'
        },
      );

      log('Response ($url): ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<dynamic> dataList = data['data'];

        return dataList.map((e) => NewsModel.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error during getNews: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<ActionModel> getOneAction(int id) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}actions/$id';
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    log('GET $url');

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $serverToken'
        },
      );

      log('Response ($url): ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return ActionModel.fromJson(data['data']);
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error during getOneAction: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<ArticleModel> getOneArticle(int id) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}articles/$id';
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    log('GET $url');

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $serverToken'
        },
      );

      log('Response ($url): ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return ArticleModel.fromJson(data['data']);
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error during getOneArticle: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<NewsModel> getOneNews(int id) async {
    String baseUrl = dotenv.env['BASE_URL']!;
    String url = '${baseUrl}news/$id';
    final String? serverToken =
        sharedPreferences.getString(SharedPreferencesKeys.accessToken);

    log('GET $url');

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $serverToken'
        },
      );

      log('Response ($url): ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return NewsModel.fromJson(data['data']);
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('Error during getOneNews: $e', level: 1000);
      rethrow;
    }
  }

  @override
  Future<List<PharmacyModel>> getPharmacies(String address) async {
  //   String baseUrl = dotenv.env['BASE_URL']!;
  //   String url = '${baseUrl}pharmacies/?address=$address';
  //   final String? serverToken =
  //       sharedPreferences.getString(SharedPreferencesKeys.accessToken);

  //   log('GET $url');

  //   try {
  //     final response = await client.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $serverToken'
  //       },
  //     );

  //     log('Response ($url): ${response.statusCode} ${response.body}');

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);

  //       List<dynamic> dataList = data['data'];

  //       return dataList.map((e) => PharmacyModel.fromJson(e)).toList();
  //     } else {
  //       throw ServerException();
  //     }
  //   } catch (e) {
  //     log('Error during getPharmacies: $e', level: 1000);
  //     rethrow;
  //   }
  // }

   await Future.delayed(Duration (milliseconds: 500)); 
   final jsonString = await rootBundle.loadString('assets/pharmacies.json');
   final data = jsonDecode(jsonString);
    List<dynamic> dataList = data['data'];
    print(data);
   return dataList.map((e) => PharmacyModel.fromJson(e)).toList();

  }
}
