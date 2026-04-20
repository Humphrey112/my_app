import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../models/news_model.dart';
import '../utilities/apis.dart';

class NewsProvider extends ChangeNotifier {
  final List<Articles> generalNewsList = [];
  final List<Articles> artNewsList = [];
  final List<Articles> economyNewsList = [];
  final List<Articles> techNewsList = [];
  final List<Articles> sportsNewsList = [];
  bool stillFetching = false;

  final Dio dio = Dio();

  Future<void> fetchAllNewsData() async {
    await fetchGeneralNewsData();
  }

  Future<void> fetchGeneralNewsData() async =>
      _fetchNews(generalNewsAPI, generalNewsList);

  Future<void> fetchArtNews() async => _fetchNews(artNewsAPI, artNewsList);

  Future<void> fetchEconomyNews() async =>
      _fetchNews(economyNewsAPI, economyNewsList);

  Future<void> fetchTechNews() async =>
      _fetchNews(techNewsAPI, techNewsList);

  Future<void> fetchSportsNews() async =>
      _fetchNews(sportsNewsAPI, sportsNewsList);

  Future<void> _fetchNews(String apiUrl, List<Articles> targetList) async {
    try {
      stillFetching = true;
      notifyListeners();

      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final newsList = (response.data['articles'] as List)
            .map((e) => Articles.fromJson(e))
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
      stillFetching = false;
      notifyListeners();
    }
  }
}
