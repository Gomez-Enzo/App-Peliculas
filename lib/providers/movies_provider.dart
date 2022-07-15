import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apikey = '1865f43a0549ca50d341dd9ab8b29f49';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _pupularPage = 0;

  MoviesProvider() {
    print('Movies provider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }
  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponce = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponce.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _pupularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _pupularPage);

    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}
