import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/film.dart';

class ApiService {
  Future<List<Movie>> listfilm() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=d05dd3724e636dc8ca314664f17e1227'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      final List<Movie> movies = List<Movie>.from(parsed['results'].map((json) => Movie.fromJson(json)));
      return movies;
    } else {
      throw Exception('Erreur');
    }
  }
}
