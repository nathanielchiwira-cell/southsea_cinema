import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model', () {
    test('should create a Movie with the correct properties', () {
      const movie = Movie(
        id: 'Avengers',
        title: 'Avengers: Endgame',
        synopsis:
            'After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos\' actions and restore balance to the universe.',
        ageRating: '12A',
        screeningTime: 'Friday 7:00 PM',
        ticketPrice: 12.50,
        imagePath: 'assets/images/avengers_endgame.jpg',
      );

      expect(movie.id, 'Avengers');
      expect(movie.title, 'Avengers: Endgame');
      expect(movie.synopsis,
          'After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos\' actions and restore balance to the universe.');
      expect(movie.ageRating, '12A');
      expect(movie.screeningTime, 'Friday 7:00 PM');
      expect(movie.ticketPrice, 12.50);
      expect(movie.imagePath, 'assets/images/avengers_endgame.jpg');
    });
    test('formattedPrice shows two decimal places for whole pounds', () {
      const movie = Movie(
        id: 'LionKing',
        title: 'The Lion King',
        synopsis:
            'A young lion prince flees his kingdom after the murder of his father, only to learn the true meaning of responsibility and bravery.',
        ageRating: 'PG',
        screeningTime: 'Saturday 2:00 PM',
        ticketPrice: 15.99,
        imagePath: 'assets/images/the_lion_king.jpg',
      );

      expect(movie.formattedPrice, '£15.99');
    });
  });
}
