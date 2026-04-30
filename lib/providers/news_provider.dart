import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../models/news_model.dart';
import '../utilities/apis.dart';

class NewsProvider extends ChangeNotifier {
  final List<Article> generalNewsList = [];
  final List<Article> artNewsList = [];
  final List<Article> economyNewsList = [];
  final List<Article> techNewsList = [];
  final List<Article> sportsNewsList = [];
  final List<Article> healthNewsList = [];
  final List<Article> funNewsList = [];
  final List<Article> scienceNewsList = [];
  final List<Article> musicNewsList = [];

  bool isLoading = false;

  final Dio dio = Dio();
/*
  // Future<void> fetchAllNewsData() async {
  //   await fetchGeneralNewsData();
  // }

  // Future<void> fetchGeneralNewsData() async =>
  //     _fetchNews(generalNewsAPI, generalNewsList);

  // Future<void> fetchArtNews() async => _fetchNews(artNewsAPI, artNewsList);

  // Future<void> fetchEconomyNews() async =>
  //     _fetchNews(economyNewsAPI, economyNewsList);

  // Future<void> fetchTechNews() async => _fetchNews(techNewsAPI, techNewsList);

  // Future<void> fetchSportsNews() async =>
  //     _fetchNews(sportsNewsAPI, sportsNewsList);*/

  //FETCH GENERAL NEWS
  Future<void> fetchGeneralNews() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await dio.get(generalNewsAPI);

      if (response.statusCode == 200) {
        List<Article> newsList = (response.data["articles"] as List)
            .map((e) => Article.fromJson(e))
            .toList();

        generalNewsList
          ..clear()
          ..addAll(newsList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //FETCH ECONOMY NEWS
  Future<void> fetchEconomyNews() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await dio.get(economyNewsAPI);

      if (response.statusCode == 200) {
        List<Article> newsList = (response.data["articles"] as List)
            .map((e) => Article.fromJson(e))
            .toList();

        economyNewsList
          ..clear()
          ..addAll(newsList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //FETCH SPORTS NEWS
  Future<void> fetchSportsNews() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await dio.get(sportsNewsAPI);

      if (response.statusCode == 200) {
        List<Article> newsList = (response.data["articles"] as List)
            .map((e) => Article.fromJson(e))
            .toList();

        sportsNewsList
          ..clear()
          ..addAll(newsList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //FETCH HEALTH NEWS
  Future<void> fetchHealthNews() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await dio.get(healthNewsAPI);

      if (response.statusCode == 200) {
        List<Article> newsList = (response.data["articles"] as List)
            .map((e) => Article.fromJson(e))
            .toList();

        healthNewsList
          ..clear()
          ..addAll(newsList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //FETCH FUN NEWS
  Future<void> fetchFunNews() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await dio.get(generalNewsAPI);

      if (response.statusCode == 200) {
        List<Article> newsList = (response.data["articles"] as List)
            .map((e) => Article.fromJson(e))
            .toList();

        funNewsList
          ..clear()
          ..addAll(newsList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //FETCH SCIENCE NEWS
  Future<void> fetchScienceNews() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await dio.get(scienceNewsAPI);

      if (response.statusCode == 200) {
        List<Article> newsList = (response.data["articles"] as List)
            .map((e) => Article.fromJson(e))
            .toList();

        scienceNewsList
          ..clear()
          ..addAll(newsList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //FETCH TECH NEWS
  Future<void> fetchTechNews() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await dio.get(techNewsAPI);

      if (response.statusCode == 200) {
        List<Article> newsList = (response.data["articles"] as List)
            .map((e) => Article.fromJson(e))
            .toList();

        techNewsList
          ..clear()
          ..addAll(newsList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //FETCH GENERAL NEWS
  Future<void> fetchMusicNews() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await dio.get(musicNewsAPI);

      if (response.statusCode == 200) {
        List<Article> newsList = (response.data["articles"] as List)
            .map((e) => Article.fromJson(e))
            .toList();

        musicNewsList
          ..clear()
          ..addAll(newsList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //FETCH GENERAL NEWS
  Future<void> fetchArtNews() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await dio.get(artNewsAPI);

      if (response.statusCode == 200) {
        List<Article> newsList = (response.data["articles"] as List)
            .map((e) => Article.fromJson(e))
            .toList();

        artNewsList
          ..clear()
          ..addAll(newsList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /*
  Future<void> _fetchNews(String apiUrl, List<Article> targetList) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final newsList = (response.data['articles'] as List)
            .map((e) => Article.fromJson(e))
            .toList();

        targetList
          ..clear()
          ..addAll(newsList);
        print(newsList);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }*/
}
