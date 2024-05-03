import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_service.dart';
import 'models/film.dart';
import 'database.dart';
import 'favori.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteMovies(),
      child: MaterialApp(
        home: FilmList(),
      ),
    );
  }
}

class FilmList extends StatefulWidget {
  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  final ApiService _apiService = ApiService();
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final List<Movie> movies = await _apiService.listfilm();
    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Films'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          final favoriteMovies = Provider.of<FavoriteMovies>(context);
          final isFavorite = favoriteMovies.isFavorite(movie);
          return ListTile(
            leading: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              width: 50,
              height: 100,
              fit: BoxFit.cover,
            ),
            title: Text(movie.title),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.blue : null,
              ),
              onPressed: () {
                if (isFavorite) {
                  favoriteMovies.removeFavorite(movie);
                } else {
                  favoriteMovies.addFavorite(movie);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
