import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apikey = '1865f43a0549ca50d341dd9ab8b29f49';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('Movies provider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }
  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);
    final nowPlayingResponce = NowPlayingResponse.fromJson(response.body);
    onDisplayMovies = nowPlayingResponce.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    popularMovies = [...popularMovies, ...popularResponse.results];
    print(popularMovies[0]);
    notifyListeners();
  }
}
