import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database.dart';
import 'models/film.dart';

class FavoriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteMovies = Provider.of<FavoriteMovies>(context);
    final List<Movie> favoris = favoriteMovies.favoriteMovies;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoris'),
      ),
      body: ListView.builder(
        itemCount: favoris.length,
        itemBuilder: (context, index) {
          final movie = favoris[index];
          return ListTile(
            leading: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              width: 50,
              height: 100,
              fit: BoxFit.cover,
            ),
            title: Text(movie.title),
          );
        },
      ),
    );
  }
}
