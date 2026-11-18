import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie>? _cachedMovies;

  List<Movie> getMovies() {
    final List<Movie>? cachedMovies = _cachedMovies;

    if (cachedMovies != null) {
      return cachedMovies;
    }

    return const [
      Movie(
        id: 'Marvels Spider Man No Way Home',
        title: "Marvels's Spider-Man: No Way Home (2021)",
        synopsis:
            "With Spider-Man's identity now revealed, Peter asks Doctor "
            'Strange for help. When a spell goes wrong, dangerous foes '
            'from other worlds start to appear, forcing Peter to discover '
            'what it truly means to be Spider-Man.',
        ageRating: 'PG-13',
        screeningTime: 'Friday 17 Aug 2024 19:30 - 22:00',
        ticketPrice: 12.50,
        imagePath: 'assets/images/spidermannn.jpg',
      ),
      Movie(
        id: 'Black Panther',
        title: 'Black Panther (2018)',
        synopsis:
            "T'Challa, heir to the hidden but advanced kingdom of Wakanda, "
            'must step forward to lead his people into a new future and '
            "must confront a challenger from his country's past.",
        ageRating: 'PG-13',
        screeningTime: 'Saturday 18 Aug 2024 18:00 - 20:15',
        ticketPrice: 10.00,
        imagePath: 'assets/images/Black_Panther_(film)_poster.jpg',
      ),
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }

    return null;
  }

  Future<List<Movie>> loadMoviesFromAsset({
    String assetPath = 'assets/data/movies.json',
  }) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final dynamic decodedData = jsonDecode(jsonString);
    final List<dynamic> jsonList = decodedData as List<dynamic>;
    final List<Movie> loadedMovies = [];

    for (final dynamic item in jsonList) {
      final Map<String, dynamic> itemMap =
          item as Map<String, dynamic>;

      final Movie movie = Movie.fromJson(itemMap);

      loadedMovies.add(movie);
    }

    _cachedMovies = loadedMovies;

    return loadedMovies;
  }
}
