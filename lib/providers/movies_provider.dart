import 'package:flutter/widgets.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    print('Movies provider inicializado');
    this.getOnDisplayMovies();
  }
  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
  }
}
