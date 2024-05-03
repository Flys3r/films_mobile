import 'package:flutter/material.dart';
import 'models/film.dart';

class FavoriteMovies extends ChangeNotifier {
  List<Movie> _favoriteMovies = [];

  List<Movie> get favoriteMovies => _favoriteMovies;

  void addFavorite(Movie movie) {
    _favoriteMovies.add(movie);
    notifyListeners();
  }

  void removeFavorite(Movie movie) {
    _favoriteMovies.remove(movie);
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favoriteMovies.contains(movie);
  }
}

