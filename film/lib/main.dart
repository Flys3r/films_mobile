import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models/film.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Films'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Movie>>(
        future: ApiService().listfilm(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasData) {
            // Si tout fonctionne les films s'affichent
            final List<Movie> movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final Movie movie = movies[index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                    width: 100,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.releaseDate.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                    },
                  ),
                );
              },
            );
          } else {
            // Si il n'y a aucun film, affiche un message
            return Center(child: Text('Aucun film trouvé'));
          }
        },
      ),
    );
  }
}





