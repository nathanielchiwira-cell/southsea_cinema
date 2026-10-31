import "package:southsea_cinema/models/movie.dart";

class MovieRepository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: "Marvels Spider Man No Way Home",
        title: "Marvels's Spider-Man: No Way Home (2021)",
        synopsis:
            "With Spider-Man's identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man.",
        ageRating: "PG-13",
        screeningTime: "Friday 17 Aug 2024 19:30 - 22:00",
        ticketPrice: 12.50,
        imagePath: "assets/images/spidermannn.jpg",
      ),
      Movie(
        id: 'Black Panther',
        title: 'Black Panther (2018)',
        synopsis: 'T\'Challa, heir to the hidden but advanced kingdom of Wakanda, must step forward to lead his people into a new future and must confront a challenger from his country\'s past.',
        ageRating: 'PG-13',
        screeningTime: 'Saturday 18 Aug 2024 18:00 - 20:15',
        ticketPrice: 10.00, 
        imagePath: 'assets/images/Black_Panther_(film)_poster.jpg',
      ),
    ];
  }
}