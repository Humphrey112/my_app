import 'package:flutter/foundation.dart';
import 'package:get_connect/get_connect.dart';
import 'package:flash/models/news_model.dart';
import 'package:flash/utilities/APIs.dart';

class NewsProvider extends ChangeNotifier {
  final List<Articles> generalNewsList = [];
  final List<Articles> artNewsList = [];
  final List<Articles> economyNewsList = [];
  final List<Articles> funNewsList = [];
  final List<Articles> healthNewsList = [];
  final List<Articles> musicNewsList = [];
  final List<Articles> scienceNewsList = [];
  final List<Articles> sportsNewsList = [];
  final List<Articles> techNewsList = [];

  bool stillFetching = false;

  final GetConnect _getConnect = GetConnect();

  Future<void> fetchAllNewsData() async {
    await fetchGeneralNewsData();
    await fetchEconomyNewsData();
    await fetchFunNewsData();
    await fetchHealthNewsData();
    await fetchMusicNewsData();
    await fetchScienceNewsData();
    await fetchSportsNewsData();
    await fetchTechNewsData();
    await fetchArtNewsData();
  }

  Future<void> fetchGeneralNewsData() async =>
      _fetchNews(generalNewsAPI, generalNewsList);

  Future<void> fetchArtNewsData() async => _fetchNews(artNewsAPI, artNewsList);

  Future<void> fetchEconomyNewsData() async =>
      _fetchNews(businessNewsAPI, economyNewsList);

  Future<void> fetchFunNewsData() async => _fetchNews(funNewsAPI, funNewsList);

  Future<void> fetchHealthNewsData() async =>
      _fetchNews(healthNewsAPI, healthNewsList);

  Future<void> fetchMusicNewsData() async =>
      _fetchNews(musicNewsAPI, musicNewsList);

  Future<void> fetchScienceNewsData() async =>
      _fetchNews(scienceNewsAPI, scienceNewsList);

  Future<void> fetchSportsNewsData() async =>
      _fetchNews(sportsNewsAPI, sportsNewsList);

  Future<void> fetchTechNewsData() async =>
      _fetchNews(techNewsAPI, techNewsList);

  Future<void> _fetchNews(String apiUrl, List<Articles> targetList) async {
    try {
      stillFetching = true;
      notifyListeners();

      final response = await _getConnect.get(apiUrl);

      if (response.statusCode == 200) {
        final newsList = (response.body['articles'] as List)
            .map((e) => Articles.fromJson(e))
            .toList();

        targetList
          ..clear()
          ..addAll(newsList);
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
