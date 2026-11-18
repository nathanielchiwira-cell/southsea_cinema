import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model', () {
    test('should create a Movie with the correct properties', () {
      const movie = Movie(
        id: 'Avengers',
        title: 'Avengers: Endgame',
        synopsis: 'After the devastating events of Avengers: Infinity War, '
            'the universe is in ruins. With the help of remaining allies, '
            'the Avengers assemble once more in order to reverse '
            "Thanos' actions and restore balance to the universe.",
        ageRating: '12A',
        screeningTime: 'Friday 7:00 PM',
        ticketPrice: 12.50,
        imagePath: 'assets/images/avengers_endgame.jpg',
      );

      expect(movie.id, 'Avengers');
      expect(movie.title, 'Avengers: Endgame');
      expect(
        movie.synopsis,
        'After the devastating events of Avengers: Infinity War, '
        'the universe is in ruins. With the help of remaining allies, '
        'the Avengers assemble once more in order to reverse '
        "Thanos' actions and restore balance to the universe.",
      );
      expect(movie.ageRating, '12A');
      expect(movie.screeningTime, 'Friday 7:00 PM');
      expect(movie.ticketPrice, 12.50);
      expect(movie.imagePath, 'assets/images/avengers_endgame.jpg');
    });

    test('formattedPrice shows two decimal places for whole pounds', () {
      const movie = Movie(
        id: 'LionKing',
        title: 'The Lion King',
        synopsis: 'A young lion learns about responsibility and bravery.',
        ageRating: 'PG',
        screeningTime: 'Saturday 2:00 PM',
        ticketPrice: 15.0,
        imagePath: 'assets/images/the_lion_king.jpg',
      );

      expect(movie.formattedPrice, '£15.00');
    });

    test('formattedPrice shows two decimal places for pence', () {
      const movie = Movie(
        id: 'LionKing',
        title: 'The Lion King',
        synopsis: 'A young lion learns about responsibility and bravery.',
        ageRating: 'PG',
        screeningTime: 'Saturday 2:00 PM',
        ticketPrice: 15.99,
        imagePath: 'assets/images/the_lion_king.jpg',
      );

      expect(movie.formattedPrice, '£15.99');
    });

    test('fromJson and toJson preserve every movie field', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'id': 'Avengers',
        'title': 'Avengers: Endgame',
        'synopsis': 'The Avengers assemble to restore the universe.',
        'ageRating': '12A',
        'screeningTime': 'Friday 7:00 PM',
        'ticketPrice': 12.50,
        'imagePath': 'assets/images/avengers_endgame.jpg',
      };

      final Movie movie = Movie.fromJson(json);

      expect(movie.id, 'Avengers');
      expect(movie.title, 'Avengers: Endgame');
      expect(
        movie.synopsis,
        'The Avengers assemble to restore the universe.',
      );
      expect(movie.ageRating, '12A');
      expect(movie.screeningTime, 'Friday 7:00 PM');
      expect(movie.ticketPrice, 12.50);
      expect(movie.imagePath, 'assets/images/avengers_endgame.jpg');

      expect(movie.toJson(), json);
    });

    test('fromJson converts a whole-number price into a double', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'id': 'LionKing',
        'title': 'The Lion King',
        'synopsis': 'A young lion learns about responsibility and bravery.',
        'ageRating': 'PG',
        'screeningTime': 'Saturday 2:00 PM',
        'ticketPrice': 15,
        'imagePath': 'assets/images/the_lion_king.jpg',
      };

      final Movie movie = Movie.fromJson(json);

      expect(movie.ticketPrice, 15.0);
      expect(movie.ticketPrice, isA<double>());
      expect(movie.formattedPrice, '£15.00');
      expect(movie.toJson(), json);
    });
  });
}
