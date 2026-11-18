import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MovieRepository', () {
    test('getMovies returns two movies', () {
      final repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);
    });

    test('getMovies contains Marvels Spider Man No Way Home and Black Panther',
        () {
      final repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      final Movie spiderMan = movies[0];
      expect(spiderMan.id, 'Marvels Spider Man No Way Home');
      expect(
        spiderMan.title,
        "Marvels's Spider-Man: No Way Home (2021)",
      );
      expect(spiderMan.ticketPrice, 12.50);
      expect(spiderMan.imagePath, isNotEmpty);

      final Movie blackPanther = movies[1];
      expect(blackPanther.id, 'Black Panther');
      expect(blackPanther.title, 'Black Panther (2018)');
      expect(blackPanther.ticketPrice, 10.00);
      expect(blackPanther.imagePath, isNotEmpty);
    });

    test('loadMoviesFromAsset reads every film from the JSON asset', () async {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = await repository.loadMoviesFromAsset();

      final String source = await rootBundle.loadString(
        'assets/data/movies.json',
      );
      final List<dynamic> jsonMovies = jsonDecode(source) as List<dynamic>;

      expect(movies.length, jsonMovies.length);
      expect(movies.length, 2);
      expect(movies[0].id, 'Marvels Spider Man No Way Home');
      expect(movies[1].id, 'Black Panther');

      for (int index = 0; index < jsonMovies.length; index++) {
        final Map<String, dynamic> expected =
            jsonMovies[index] as Map<String, dynamic>;

        expect(movies[index].toJson(), expected);
      }

      expect(repository.getMovies(), movies);
    });
  });
}
