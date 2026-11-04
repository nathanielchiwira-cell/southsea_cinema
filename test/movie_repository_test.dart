import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart'; 
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository', () {
    test('getMovies returns two movies', () {
      final repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);
    });
    
    test('getMovies contains Marvels Spider Man No Way Home and Black Panther', () {
      final repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      final Movie spiderMan = movies[0];
      expect(spiderMan.id, 'Marvels Spider Man No Way Home');
      expect(spiderMan.title, 'Marvels\'s Spider-Man: No Way Home (2021)');
      expect(spiderMan.ticketPrice, 12.50);
      expect(spiderMan.imagePath, isNotEmpty);

      final Movie blackPanther = movies[1];
      expect(blackPanther.id, 'Black Panther');
      expect(blackPanther.title, 'Black Panther (2018)');
      expect(blackPanther.ticketPrice, 10.00);
      expect(blackPanther.imagePath, isNotEmpty);
    });
  });
}

